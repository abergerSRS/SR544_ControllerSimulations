close all
clear all

J = 1.66e-5;
%KD = 1.95e-9;
KD = 1.33e-8;
KT = 7.5e-3;
pow = 1.88;

simOut = sim('DC_motor_with_PID',...
            'SaveOutput','on','OutputSaveName','yout');

yout = simOut.get('yout');
tout = simOut.get('tout');

total_PID_out = yout(:,1);
motor_speed = yout(:,2);
motor_angle_deg = yout(:,3);
phase_error_revs = yout(:,4);
speed_error_Hz = yout(:,5);
speed_PID_out = yout(:,6);
phase_PID_out = yout(:,7);
ref_angle_deg = yout(:,8);

figure
plot(tout,speed_error_Hz,'b','LineWidth',2)
hold
plot(tout,phase_error_revs,'r','LineWidth',2)
legend('speed error (Hz)','phase error (revs)')
xlabel('time (s)')
ylabel('error')
xlim([3 12])
ylim([-1 1])

figure
plot(tout,total_PID_out,'g','LineWidth',2)
legend('total PID output')
xlabel('time (s)')
ylabel('output')
xlim([3 12])
ylim([-0.1 0.5])


