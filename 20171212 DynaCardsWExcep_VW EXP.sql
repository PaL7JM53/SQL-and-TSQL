--exception report
USE [EOSProdCalculations];
GO
SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO
ALTER PROCEDURE [dbo].[procTCardExcep ] AS

BEGIN
  
  if exists (select 
PlungerTransDB.dbo.TCardHeader.TransactionId
from
PlungerTransDB.dbo.TCardHeader,
TCardExceptions
Where PlungerTransDB.dbo.TCardHeader.TransactionId > TCardExceptions.TransactionId)
  
    with DownLoadPosPerc as (select 
distinct 
PlungerTransDB.dbo.TCardData.TransactionId
,(percentile_cont(0.30) within group (order by LoadData) over (partition by PlungerTransDB.dbo.TCardData.TransactionId)) LoadPer 
from PlungerTransDB.dbo.TCardData
where PlungerTransDB.dbo.TCardData.surface=0
and PlungerTransDB.dbo.TCardData.PosData < 10
)

-----------comparing the change from a previous value and applying filters

,DownDiffPrev as ( select PlungerTransDB.dbo.TCardData.TransactionId
,(PlungerTransDB.dbo.TCardData.LoadData - PrevTCard.LoadData) DownDiffPrevLoad
,PlungerTransDB.dbo.TCardData.PairIndex
from PlungerTransDB.dbo.TCardData
inner join PlungerTransDB.dbo.TCardData as PrevTCard on PlungerTransDB.dbo.TCardData.TransactionId=PrevTCard.TransactionId
                                  and (PlungerTransDB.dbo.TCardData.PairIndex-1)=PrevTCard.PairIndex
inner join DownLoadPosPerc on PlungerTransDB.dbo.TCardData.TransactionId=DownLoadPosPerc.TransactionId
where PlungerTransDB.dbo.TCardData.Surface = 0 and PrevTCard.surface = 0
and PlungerTransDB.dbo.TCardData.LoadData < DownLoadPosPerc.LoadPer
and PlungerTransDB.dbo.TCardData.PosData < 10
)

---------min greater than 10 pos

,DownRightMin as (select TransactionId, min (LoadData) as MinRight 
from PlungerTransDB.dbo.TCardData 
where PosData > 10
and Surface = 0
group by TransactionId)

---------filtering

,DownCardTag as ( select distinct
 PlungerTransDB.dbo.TCardData.TransactionId
 from PlungerTransDB.dbo.TCardData
inner join DownDiffPrev on DownDiffPrev.TransactionId =PlungerTransDB.dbo.TCardData.TransactionId
inner join DownRightMin on DownRightMin.TransactionId =PlungerTransDB.dbo.TCardData.TransactionId
where DownDiffPrevLoad < -500
and PlungerTransDB.dbo.TCardData.LoadData<DownRightMin.MinRight
)
 
-------$$  OVER TRAVEL   $$----

, MaxSurfPos as (select PlungerTransDB.dbo.TCardData.TransactionId
,max(PlungerTransDB.dbo.TCardData.PosData) as MaxSurfPos
from PlungerTransDB.dbo.TCardData
where PlungerTransDB.dbo.TCardData.Surface = 1
group by PlungerTransDB.dbo.TCardData.TransactionId)

,MaxBtmPos as (select PlungerTransDB.dbo.TCardData.TransactionId
,max(PlungerTransDB.dbo.TCardData.PosData) as MaxBtmPos
from PlungerTransDB.dbo.TCardData
where PlungerTransDB.dbo.TCardData.Surface = 0
group by PlungerTransDB.dbo.TCardData.TransactionId)

------$$  SURFACE   $$-------

------PairIndex at Max-------

,MaxPosPairIndex as (select PlungerTransDB.dbo.TCardData.TransactionId
,PlungerTransDB.dbo.TCardData.PairIndex
from PlungerTransDB.dbo.TCardData
inner join MaxSurfPos on MaxSurfPos.TransactionId=PlungerTransDB.dbo.TCardData.TransactionId
                      and MaxSurfPos.MaxSurfPos=PlungerTransDB.dbo.TCardData.PosData

where PlungerTransDB.dbo.TCardData.Surface = 1) 

--select * from MaxPosPairIndex where MaxPosPairIndex.TransactionId = 91719

-----------comparing the change from a previous value and applying filters

,SurfTag as ( select distinct PlungerTransDB.dbo.TCardData.TransactionId
from PlungerTransDB.dbo.TCardData
inner join PlungerTransDB.dbo.TCardData as PrevTCard on PlungerTransDB.dbo.TCardData.TransactionId=PrevTCard.TransactionId
                                  and (PlungerTransDB.dbo.TCardData.PairIndex-1)=PrevTCard.PairIndex
inner join        MaxPosPairIndex on PlungerTransDB.dbo.TCardData.TransactionId=MaxPosPairIndex.TransactionId
where PlungerTransDB.dbo.TCardData.Surface = 1 and PrevTCard.surface = 1
and PlungerTransDB.dbo.TCardData.PosData < 50
and (PlungerTransDB.dbo.TCardData.LoadData - PrevTCard.LoadData) < -2000
and PrevTCard.PairIndex< MaxPosPairIndex.PairIndex
--and PlungerTransDB.dbo.TCardData.transactionid='7910'
)

-------$$  LOSS OF SURFACE WEIGHT  $$----
,Pos30t40 as (select PlungerTransDB.dbo.TCardData.TransactionId
,max(PlungerTransDB.dbo.TCardData.LoadData) as Max30t40Load
,min(PlungerTransDB.dbo.TCardData.LoadData) as Min30t40Load
from PlungerTransDB.dbo.TCardData
where PlungerTransDB.dbo.TCardData.Surface = 1
and PlungerTransDB.dbo.TCardData.PosData > 30
and PlungerTransDB.dbo.TCardData.PosData < 40
group by PlungerTransDB.dbo.TCardData.TransactionId)

,Pos70t80 as (select PlungerTransDB.dbo.TCardData.TransactionId
,max(PlungerTransDB.dbo.TCardData.LoadData) as Max70t80Load
,min(PlungerTransDB.dbo.TCardData.LoadData) as Min70t80Load
from PlungerTransDB.dbo.TCardData
where PlungerTransDB.dbo.TCardData.Surface = 1
and PlungerTransDB.dbo.TCardData.PosData > 70
and PlungerTransDB.dbo.TCardData.PosData < 80
group by PlungerTransDB.dbo.TCardData.TransactionId)

-------$$  LOSS OF BOTTOMHOLE WEIGHT  $$----
,BtmPos30t40 as (select PlungerTransDB.dbo.TCardData.TransactionId
,max(PlungerTransDB.dbo.TCardData.LoadData) as Max30t40Load
,min(PlungerTransDB.dbo.TCardData.LoadData) as Min30t40Load
from PlungerTransDB.dbo.TCardData
where PlungerTransDB.dbo.TCardData.Surface = 0
and PlungerTransDB.dbo.TCardData.PosData > 30
and PlungerTransDB.dbo.TCardData.PosData < 40
group by PlungerTransDB.dbo.TCardData.TransactionId)

,BtmPos70t80 as (select PlungerTransDB.dbo.TCardData.TransactionId
,max(PlungerTransDB.dbo.TCardData.LoadData) as Max70t80Load
,min(PlungerTransDB.dbo.TCardData.LoadData) as Min70t80Load
from PlungerTransDB.dbo.TCardData
where PlungerTransDB.dbo.TCardData.Surface = 0
and PlungerTransDB.dbo.TCardData.PosData > 70
and PlungerTransDB.dbo.TCardData.PosData < 80
group by PlungerTransDB.dbo.TCardData.TransactionId)

---------all cards
  
    insert into TCardExceptions (TransactionID, Exceptions)
    
    select

	PlungerTransDB.dbo.TCardHeader.TransactionId,

case 
when DownCardTag.TransactionId is not null and  SurfTag.TransactionId is not null then 'Tagging Both Cards' 
when DownCardTag.TransactionId is not null then 'Tagging Downhole Card' 
when SurfTag.TransactionId is not null then 'Tagging Surface Card' 
when (Pos30t40.Max30t40Load - Pos30t40.Min30t40Load) < 1000 and (Pos70t80.Max70t80Load-Pos70t80.Min70t80Load) < 1000 
then 'Loss Of Surface Weight'
when (BtmPos30t40.Max30t40Load - BtmPos30t40.Min30t40Load) < 1000 and (BtmPos70t80.Max70t80Load-BtmPos70t80.Min70t80Load) < 1000 
then 'Loss Of BottomHole Weight'
when (MaxBtmPos.MaxBtmPos-8) > MaxSurfPos.MaxSurfPos and PlungerTransDB.dbo.TCardHeader.Site = 'MAVERICK' then 'OverTravel in Maverick'
else ' No Exception'
end as EXCEPTIONS


from PlungerTransDB.dbo.TCardHeader
left outer join DownCardTag on PlungerTransDB.dbo.TCardHeader.TransactionId=DownCardTag.TransactionId
left outer join SurfTag on PlungerTransDB.dbo.TCardHeader.TransactionId=SurfTag.TransactionId
left outer join MaxSurfPos on PlungerTransDB.dbo.TCardHeader.TransactionId=MaxSurfPos.TransactionId
left outer join MaxBtmPos on PlungerTransDB.dbo.TCardHeader.TransactionId=MaxBtmPos.TransactionId
left outer join Pos30t40 on PlungerTransDB.dbo.TCardHeader.TransactionId=Pos30t40.TransactionId
left outer join Pos70t80 on PlungerTransDB.dbo.TCardHeader.TransactionId=Pos70t80.TransactionId
left outer join BtmPos30t40 on PlungerTransDB.dbo.TCardHeader.TransactionId=BtmPos30t40.TransactionId
left outer join BtmPos70t80 on PlungerTransDB.dbo.TCardHeader.TransactionId=BtmPos70t80.TransactionId
left outer join TCardExceptions on PlungerTransDB.dbo.TCardHeader.TransactionId=TCardExceptions.TransactionId

Where TCardExceptions.TransactionId is null
and PlungerTransDB.dbo.TCardHeader.CardTimestamp > getdate()-60 

  
END
GO