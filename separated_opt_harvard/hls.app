<project xmlns="com.autoesl.autopilot.project" name="separated_opt_harvard" top="processor" projectType="C/C++">
    <includePaths/>
    <libraryPaths/>
    <Simulation>
        <SimFlow name="csim" csimMode="0" lastCsimMode="2"/>
    </Simulation>
    <files xmlns="">
        <file name="separated_opt_harvard/src/rv32i.cpp" sc="0" tb="false" cflags="-Iseparated_opt_harvard/include" csimflags="" blackbox="false"/>
        <file name="../src/processor_tb.cpp" sc="0" tb="1" cflags="-I../include -Wno-unknown-pragmas" csimflags="" blackbox="false"/>
        <file name="../src/processor_tb_big.cpp" sc="0" tb="1" cflags="-I../include -Wno-unknown-pragmas" csimflags="" blackbox="false"/>
    </files>
    <solutions xmlns="">
        <solution name="Try1" status="inactive"/>
        <solution name="Try2" status="active"/>
    </solutions>
</project>

