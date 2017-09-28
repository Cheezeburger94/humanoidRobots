classdef MotorHSC
    properties(SetAccess = private)
        % Port connection
        PROTOCOL_VERSION            = 1.0;
        BAUDRATE                    = 1000000;
        DEVICENAME                  = 'COM4';
        COMM_SUCCESS =  0;
        port_num
        % Addresses
        ADDR_AX_TORQUE_ENABLE       = 24;
        ADDR_AX_GOAL_POSITION       = 30;
        ADDR_AX_PRESENT_POSITION    = 36;
        % Constraints
        MIN_POS = 0;
        MAX_POS = 1023;
        TORQUE_ENABLE               = 1;
        TORQUE_DISABLE              = 0;
    end
    
    methods
        function obj = MotorHSC()
            obj.loadLibrary;
            obj.port_num = portHandler(obj.DEVICENAME);
            packetHandler();
            if ~openPort(obj.port_num)
                error('MotorHSC: Failed to open port');
            end
            if ~setBaudRate(obj.port_num, obj.BAUDRATE)
                error('MotorHSC: Failed to set baudrate');
            end
        end
        
        function closeConnection(hsc_obj)
            closePort(hsc_obj.port_num);
        end
        
        function moveToPosition(hsc_obj,dxl_id,goalPosition)
            % Mirrorize even ids
            if mod(dxl_id,2)==0
                goalPosition = 1 - goalPosition;
            end
            % Rescale position
            rescaledPos = goalPosition*hsc_obj.MAX_POS;
            % Write to motor
            write2ByteTxRx(hsc_obj.port_num, hsc_obj.PROTOCOL_VERSION, dxl_id, hsc_obj.ADDR_AX_GOAL_POSITION, rescaledPos);
        end
        
        function position = readPosition(hsc_obj,dxl_id)
            position = read2ByteTxRx(hsc_obj.port_num, hsc_obj.PROTOCOL_VERSION, dxl_id, hsc_obj.ADDR_AX_PRESENT_POSITION);
            % Rescale
            position = position/(hsc_obj.MAX_POS-hsc_obj.MIN_POS);
            % Mirrorize even ids
            if mod(dxl_id,2)==0
                position = 1 - position;
            end
        end
        
        function enableTorque(hsc_obj,dxl_id)
            write1ByteTxRx(hsc_obj.port_num, hsc_obj.PROTOCOL_VERSION, dxl_id, hsc_obj.ADDR_AX_TORQUE_ENABLE, hsc_obj.TORQUE_ENABLE);
        end
        
        function disableTorque(hsc_obj,dxl_id)
            write1ByteTxRx(hsc_obj.port_num, hsc_obj.PROTOCOL_VERSION, dxl_id, hsc_obj.ADDR_AX_TORQUE_ENABLE, hsc_obj.TORQUE_DISABLE);
        end
        
        function standUpRobot(hsc_obj) % Puts robot in standing pose and turns on torque for all motors
            posArray = [334,687,297,723,410,610,356,666,489,532,396,628,279,743,639,385,491,532];
            for i=1:length(posArray)
                goalPos = posArray(i);
                write1ByteTxRx(hsc_obj.port_num, hsc_obj.PROTOCOL_VERSION, i, hsc_obj.ADDR_AX_TORQUE_ENABLE, hsc_obj.TORQUE_ENABLE);
                write2ByteTxRx(hsc_obj.port_num, hsc_obj.PROTOCOL_VERSION, i, hsc_obj.ADDR_AX_GOAL_POSITION, goalPos);
            end
        end
        
        function disableAllTorque(hsc_obj)
            for i=1:18
                dxl_id = i;
                write1ByteTxRx(hsc_obj.port_num, hsc_obj.PROTOCOL_VERSION, dxl_id, hsc_obj.ADDR_AX_TORQUE_ENABLE, hsc_obj.TORQUE_DISABLE);
            end
        end
        
    end
    
    methods(Static, Access = private)
        function loadLibrary()
            if strcmp(computer, 'PCWIN')
                lib_name = 'dxl_x86_c';
            elseif strcmp(computer, 'PCWIN64')
                lib_name = 'dxl_x64_c';
            elseif strcmp(computer, 'GLNX86')
                lib_name = 'libdxl_x86_c';
            elseif strcmp(computer, 'GLNXA64')
                lib_name = 'libdxl_x64_c';
            elseif strcmp(computer, 'MACI64')
                lib_name = 'libdxl_mac_c';
            end
            
            if ~libisloaded(lib_name)
                [~, ~] = loadlibrary(lib_name, 'dynamixel_sdk.h', 'addheader', 'port_handler.h', 'addheader', 'packet_handler.h');
            end
        end
        
    end
end
