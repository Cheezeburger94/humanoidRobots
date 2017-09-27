function writeToMotor(port_num, PROTOCOL_VERSION, DXL_ID, ADDR_AX, writeData,byte)

if byte==2
    write2ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID, ADDR_AX, writeData);
elseif byte == 1
    write1ByteTxRx(port_num, PROTOCOL_VERSION, DXL_ID, ADDR_AX, writeData);
else
    disp('Byte argument must be 1 or 2');
    return;
end

% Check for errors
dxl_comm_result = getLastTxRxResult(port_num, PROTOCOL_VERSION);
dxl_error = getLastRxPacketError(port_num, PROTOCOL_VERSION);
if dxl_comm_result ~= 0
    fprintf('%s\n', getTxRxResult(PROTOCOL_VERSION, dxl_comm_result));
elseif dxl_error ~= 0
    fprintf('%s\n', getRxPacketError(PROTOCOL_VERSION, dxl_error));
end

end