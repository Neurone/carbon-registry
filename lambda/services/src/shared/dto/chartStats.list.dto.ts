import { ApiProperty, ApiPropertyOptional } from "@nestjs/swagger";
import { Type } from "class-transformer";
import { IsNotEmptyObject, IsNumber, IsObject, IsOptional, IsPositive, ValidateNested } from "class-validator";
import { ChartStat } from "./chartStats.dto";

export class ChartStatList {

    @ApiProperty({isArray: true, type: ChartStat})
    @ValidateNested()
    stats: ChartStat[];

    @IsPositive()
    @IsNumber()
    @ApiPropertyOptional()
    @IsOptional()
    startTime: number;

    @IsPositive()
    @IsNumber()
    @ApiPropertyOptional()
    @IsOptional()
    endTime: number;
}