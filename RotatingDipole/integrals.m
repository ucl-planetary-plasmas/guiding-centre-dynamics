function [intsstruct, alpha0] = integrals(al, beta0, a0mx, na0)
% ints = integrals(a,b, options)
% Description:
% Compute the dimensionless integrals entering into the computation of the
% period of motion for the dimensionless parameters al (loss cone at the
% magnetic equator) and b0.
%
% Inputs:
% al : meshgrid(L, E0) : a_loss (loss cone at the magnetic equator)
% b0 : meshgrid(L, E0) : b0 aka \beta_0
% from dimensionless(casestudy)
%
% Outputs:
% ints: structure containing lm, phi, gc, gg, gcg, gcf, gamma,...
%                            pOgc, pOgg, pOgcg, pOgcf, phiOgamma.
%
% $Author: Sabine Ogier-Collin$
% $Date: 2022-05-18$ v0

disp(['Integrals; ' ...
    'max(a0) = ', num2str(a0mx), ...
    ', numPages = ', num2str(na0)]);

%Initialisation
[numRows,numCols] = size(beta0);
numPages = na0;
alpha0 = zeros(numRows,numCols,numPages);
lm = NaN(size(alpha0));
phi = NaN(size(alpha0));
gg = NaN(size(alpha0));
gc = NaN(size(alpha0));
gcf = NaN(size(alpha0));
gcg_direct = NaN(size(alpha0));
%Loops and integrate
for i = 1:numRows
    for j = 1:numCols
        if i>numRows || j >numCols
            b0 = 0;
        else
            b0 = beta0(i,j);
        end
        alpha0(i, j,:) = linspace(0, a0mx, na0);
        for k=numPages:-1:1
            if alpha0(i, j, k)<al(i,j)
                alpha0(i, j, k)=nan;
            else
                a0 = alpha0(i,j,k);
                %               Lm
                if k == numPages
%                     initpt = pi/4;
                    intsearch = [0, pi/4];
                else
%                     initpt = lm(i, j, k+1);
                    intsearch = [lm(i, j, k+1), pi/2];
                end
%                 disp(['(a0, b0) = (', num2str(a0), ' , ', num2str(b0), ' );'])
%                 disp(initpt)
                f = @(a,b,x) cos(x).^6.*(1-b.*(1-cos(x).^6))-sin(a)^2.*sqrt(1+3*sin(x).^2);
                opts = optimset('FunValCheck','on');
                %lm(i, j, k) = fzero(@(x) f(a0, b0, x), initpt, opts);
                lm(i, j, k) = fzero(@(x) f(a0, b0, x), intsearch, opts);
%                 disp(lm(i, j, k))

                %               Phi
                opts_phi = {'AbsTol',1e-9,'RelTol',1e-6}; %'ArrayValued',true
                phi(i, j, k) = integral(@(t)phird(t,a0,b0),0,lm(i, j, k), ...
                    opts_phi{:});

                %               Gammas
                opts_gamma = {'AbsTol',1e-12,'RelTol',1e-9,'Waypoints',lm(i,j,k)};
                EPS = 1e-5;%To avoid the singularity around lm
                gc(i, j, k) = 3*integral(@(t)omrdc(t,a0,b0),0,lm(i, j, k), ...
                    opts_gamma{:});
                gg(i, j, k) = 3*integral(@(t)omrdg(t,a0,b0),0,lm(i, j, k), ...
                    opts_gamma{:});
                gcf(i, j, k) = b0*integral(@(t)omrdcf(t,a0,b0),0,lm(i, j, k)-EPS, ...
                    opts_gamma{:});
%                 disp(lm(i,j,k))
%                 disp(gcf(i,j,k))
                gcg_direct(i, j, k) = 3*integral(@(t)omrdcg(t,a0,b0),0,lm(i, j, k), ...
                    opts_gamma{:});
            end
        end

    end
end
% Composition
gcg = gg + gc;
pOgcg = phi./gcg;

pOgg = phi./gg;
pOgc = phi./gc;
pOgcf = phi./gcf;
pOgcg_direct = phi./gcg_direct;

gamma = real(gcg) + real(gcf);
phiOgamma = phi./gamma;

% Store in a structure
intsstruct = struct('a0', alpha0, ...
    'lm', lm, 'phi', phi, ...
    'gamma', gamma, 'phiOgamma', phiOgamma,...
    'gg', gg, 'pOgg', pOgg,...
    'gc', gc, 'pOgc', pOgc,...
    'gcg', gcg, 'pOgcg', pOgcg,...
    'gcf', gcf, 'pOgcf', pOgcf,...
    'gcg_direct', gcg_direct, 'pOgcg_direct', pOgcg_direct ...
    );


% integrand functions
    function y=phird(t,a,b)
        y = cos(t).*sqrt(1+3*sin(t).^2)./ ...
            (sqrt(1-sqrt(1+3*sin(t).^2)*sin(a)^2./(cos(t).^6.*(1-b.*(1-cos(t).^6)))).*...
            sqrt(1-b.*(1-cos(t).^6)));
    end

    function y=omrdc(t,a,b)
        y = sqrt(1-(sqrt(1+3*sin(t).^2)*sin(a)^2./cos(t).^6)...
            -b.*(1-cos(t).^6)).* ...
            cos(t).^3.*(sin(t).^2+1)./(1+3*sin(t).^2).^1.5;
    end

    function y=omrdg(t,a,b)
        y = sin(a)^2./sqrt(1-(sqrt(1+3*sin(t).^2)*sin(a)^2./cos(t).^6)...
            - b.*(1-cos(t).^6))./cos(t).^3.*(1+sin(t).^2)./(1+3*sin(t).^2)/2;
    end

    function y=omrdcf(t,a,b)
        y = (cos(t).^9./(1-(sqrt(1+3*sin(t).^2)*sin(a)^2./cos(t).^6)- b.*(1-cos(t).^6)))...
            .*(1-3.*sin(t).^2)./sqrt(1+3*sin(t).^2);
    end

    function y=omrdcg(t,a,b)
        y = (1-(sqrt(1+3*sin(t).^2)*sin(a)^2/2./cos(t).^6)...
            -b.*(1-cos(t).^6))./ ...
            sqrt(1-(sqrt(1+3*sin(t).^2)*sin(a)^2./cos(t).^6)...
            -b.*(1-cos(t).^6)).* ...;
    		cos(t).^3.*(1+sin(t).^2)./(1+3*sin(t).^2).^1.5;
    end


end

% save(matexportfile,...
%     'lmrd',...
% 	'phird',...
%     'omrd',...
%     'omrdc',...
%     'omrdg',...
%     'omrdcg',...
%     'omrdcf');

