<project xmlns="com.autoesl.autopilot.project" top="processor" name="all_in_one_aplib" projectType="C/C++">
    <includePaths/>
    <libraryPaths/>
    <Simulation>
        <SimFlow name="csim" csimMode="0" lastCsimMode="0"/>
    </Simulation>
    <files xmlns="">
        <file name="all_in_one_aplib/src/rv32i.cpp" sc="0" tb="false" cflags="-Iall_in_one_aplib/include" csimflags="" blackbox="false"/>
        <file name="../src/processor_tb.cpp" sc="0" tb="1" cflags="-I../include -Wno-unknown-pragmas" csimflags="" blackbox="false"/>
        <file name="../src/processor_tb_big.cpp" sc="0" tb="1" cflags="-I../include -Wno-unknown-pragmas" csimflags="" blackbox="false"/>
    </files>
    <solutions xmlns="">
        <solution name="Try1" status="active"/>
    </solutions>
</project>

