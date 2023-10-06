<project xmlns="com.autoesl.autopilot.project" name="all_in_one_harvard" top="processor" projectType="C/C++">
    <includePaths/>
    <libraryPaths/>
    <Simulation>
        <SimFlow name="csim" csimMode="2" lastCsimMode="2"/>
    </Simulation>
    <files xmlns="">
        <file name="all_in_one_harvard/src/rv32i.cpp" sc="0" tb="false" cflags="-Iall_in_one_harvard/include" csimflags="" blackbox="false"/>
        <file name="../src/processor_tb.cpp" sc="0" tb="1" cflags="-I../include -Wno-unknown-pragmas" csimflags="" blackbox="false"/>
        <file name="../src/processor_tb_big.cpp" sc="0" tb="1" cflags="-I../include -Wno-unknown-pragmas" csimflags="" blackbox="false"/>
    </files>
    <solutions xmlns="">
        <solution name="Try1" status="active"/>
        <solution name="Try2" status="inactive"/>
    </solutions>
</project>

