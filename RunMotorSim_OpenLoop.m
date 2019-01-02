close all
clear all

J = 1.66e-5;
%KD = 1.95e-9; %not sure where this number came from
KD = 1.33e-8;
KT = 7.5e-3;
pow = 2;

simOut = sim('DC_Motor_impulseTest',...
            'SaveOutput','on','OutputSaveName','yout');

yout = simOut.get('yout');
tout = simOut.get('tout');

motor_speed = yout(:,1);
% motor_angle_deg = yout(:,2);

figure
plot(tout,motor_speed,'b','LineWidth',2)
xlabel('time (s)')
ylabel('motor speed (Hz)')
