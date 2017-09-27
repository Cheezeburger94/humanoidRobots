%% Attempts to read data from dynamixel motor
function readData = readFromMotor(port_num, PROTOCOL_VERSION, DXL_ID, ADDR_AX,byteData)

% Read from dynamixel
if byteData== 1
    readData = read1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID, ADDR_AX);
elseif byteData == 2
    readData = read2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID, ADDR_AX);
else
    disp('Invalid argument, byteData must be 1 or 2');
    return
end

% Check communication
dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
if dxl_comm_result ~= 0
    fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
elseif dxl_error ~= 0
    fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
end

end