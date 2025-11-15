--pivot to flatten data

declare @MyField int;
DECLARE @MyCursor CURSOR;
--drop table if exists #WellTestDataUnPiv;  -- remove for second run
begin
		SET @MyCursor = CURSOR FOR
	select ID from [dbo].[Analytics_PressureModels]  
--	where id = #redacted -- remove for second run
	where id in (#redacted
)
	    OPEN @MyCursor 
    FETCH NEXT FROM @MyCursor 
    INTO @MyField

    WHILE @@FETCH_STATUS = 0
    BEGIN
			DECLARE @WellTestData NVARCHAR(MAX)
			drop table if exists #WellTestDataPiv

			
			set @WellTestData = (select WellTestData from [dbo].[Analytics_PressureModels]  where id = @MyField)

			select * into #WellTestDataPiv from openjson(@WellTestData)

			insert into #WellTestDataUnPiv  --add for second run
			select 
			@MyField as ID,
			WellTestDate
			,OilRate
			,ReservoirGasRate
			,WaterRate
			,LiftGasRate
			,IsLatestWellTest
			,Sum_Date
			,DownholePressure
			,TubingPressure
			,TubingTemperature
			,CasingPressure
			,CasingTemperature
			,GLR
			,G_RLR
			,GLR_total
			,GLR_injected
			,GOR
			,WOR
			,GOR_total
			,GasRate
			--into #WellTestDataUnPiv  -- remove for second run
			from
			( 
			select [key],[value] from #WellTestDataPiv
			)d
			pivot(
			max(value) 
			for [key] in (WellTestDate
			,OilRate
			,ReservoirGasRate
			,WaterRate
			,LiftGasRate
			,IsLatestWellTest
			,Sum_Date
			,DownholePressure
			,TubingPressure
			,TubingTemperature
			,CasingPressure
			,CasingTemperature
			,GLR
			,G_RLR
			,GLR_total
			,GLR_injected
			,GOR
			,WOR
			,GOR_total
			,GasRate))piv

			


      FETCH NEXT FROM @MyCursor 
      INTO @MyField 
    END; 

    CLOSE @MyCursor ;
    DEALLOCATE @MyCursor;

	select  * from #WellTestDataUnPiv
END;
	

	--select  * from #WellTestDataUnPiv