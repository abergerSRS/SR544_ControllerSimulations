close all
%clear all

J = 1.66e-5;
%KD = 1.95e-9; %not sure where this number came from
KD = 1.33e-8;
KT = 7.5e-3;
pow = 1.88;

k_p = 0.02;
k_i = 0.01;
N = 75;

set_param('DC_motor_with_PID/Speed PID','P',num2str(k_p))
set_param('DC_motor_with_PID/Speed PID','I',num2str(k_i))

for i = 1:length(N)
    filter = ones(1,N(i))/N(i);
    set_param('DC_motor_with_PID/150-pt moving average','Coefficients',strcat('[',num2str(filter),']'))
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
    ref_speed_Hz = yout(:,9);

    
    if i == 1
        figure
        plot(tout,ref_speed_Hz,'r','LineWidth',2)
        hold
    end
    plot(tout,motor_speed,'b','LineWidth',2)
    if i == 1
        legend('ref (Hz)','motor (Hz)')
        xlabel('time (s)')
        ylabel('freq (Hz)')
    end
    % xlim([0 12])
    % ylim([-1 1])

    figure
    % plot(tout,total_PID_out,'g','LineWidth',2)
    % hold
    plot(tout,speed_PID_out,'b','LineWidth',2)
    % plot(tout,phase_PID_out,'r','LineWidth',2)
    legend('total PID output','speed PID output','phase PID output')
    xlabel('time (s)')
    ylabel('output')
    % xlim([0 12])
    % ylim([-0.1 0.5])
end


