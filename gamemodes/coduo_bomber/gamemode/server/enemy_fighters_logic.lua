function EnemyFightersLogic()
    local NextDummyAttackerSpawn = 0
    HookAdd("Think", "SpawnDummyHunters", function()
        if (!BOMBER_ENEMY_FIGHTERS) then return end
        if (#ents.GetBombers() <= 0) then return end

        if (CurTime() >= NextDummyAttackerSpawn) then
            NextDummyAttackerSpawn = CurTime() + 2.5

            FighterAttackFriendlies()
        end
    end)
    
    local NextPlayerAttackerSpawn = 0
    HookAdd("Think", "SpawnPlayerBomberHunters", function()
        if (!BOMBER_ENEMY_FIGHTERS) then return end

        if (CurTime() >= NextPlayerAttackerSpawn) then
			local cooldownScale = 1.6 * ( (#ents.GetBombers() / 18) - 1 )
            NextPlayerAttackerSpawn = CurTime() + 2.75 + (-cooldownScale)

            FighterAttackPlayer()
        end
    end)
end

function FighterAttackFriendlies()
	local bombers = ents.GetBombers()

	local me = ents.Create("ai_me109")
	me:StartHunting( bombers[math.random(#bombers)] )
	me:SetPos( ME109_HUNT_SPAWNS[math.random(#ME109_HUNT_SPAWNS)] ) 
	me:SetAngles(me:GetRotationTowardsTarget(me.Target))
	me:Spawn()
end

function FighterAttackPlayer()
	local me = ents.Create("ai_me109")
	me:AttackPlayerBomber()
	me:FollowWaypoints(ME109_WAYPOINTS[math.random(1, #ME109_WAYPOINTS)], 1, true)
    me:Spawn()
end

util.AddNetworkString("PLAY_MUSIC")
function StartEnemyFighters()
    BOMBER_ENEMY_FIGHTERS = true

	net.Start("PLAY_MUSIC")
	net.Broadcast()
end

util.AddNetworkString("STOP_MUSIC")
function StopEnemyFighters()
    BOMBER_ENEMY_FIGHTERS = false

	net.Start("STOP_MUSIC")
	net.Broadcast()

    timer.Remove("EVENT_MANAGER_FIGHTERS_START")
    timer.Remove("EVENT_MANAGER_FIGHTERS_STOP")
end

ME109_HUNT_SPAWNS = {
    Vector(-10410.251953125, 15271.42578125, 2117.2836914063),
    Vector(-15228.00390625, 11168.229492188, 3925.3940429688),
    Vector(-15449.192382813, 4137.474609375, 2668.7153320313),
    Vector(-15092.206054688, -7323.0732421875, 2103.2434082031),
    Vector(-14973.370117188, -10061.990234375, 4171.529296875),
    Vector(-12847.228515625, -15347.567382813, 1866.3729248047),
    Vector(11905.953125, -15220.725585938, 1867.8172607422),
    Vector(14535.815429688, -13867.686523438, 3777.00390625),
    Vector(15760.640625, 4234.9384765625, 1293.3273925781),
    Vector(13656.306640625, 15984.048828125, 2474.7529296875),
    Vector(5080.0610351563, 15022.923828125, -1644.0126953125)
}

ME109_WAYPOINTS = {
    // Front:
	{
		Vector(15997.687500, -11331.468750, 2783.812500),
		Vector(12070.281250, -11748.312500, 2458.500000),
		Vector(7858.031250, -11013.093750, 1930.187500),
		Vector(4553.062500, -7114.218750, 1315.812500),
		Vector(1392.187500, -2020.312500, 322.718750),
		Vector(298.343750, 901.343750, 298.593750),
		Vector(-1037.062500, 4809.625000, 294.812500),
		Vector(-3693.906250, 8092.875000, -648.937500),
		Vector(-11219.031250, 8597.843750, -2484.218750)
	},
	{
		Vector(-13276.687500, -15577.500000, 3761.312500),
		Vector(-9078.343750, -12021.281250, 2871.125000),
		Vector(-4436.562500, -6784.343750, 1589.031250),
		Vector(-1533.781250, -2366.875000, 469.312500),
		Vector(629.281250, -205.937500, -1131.968750),
		Vector(4542.781250, 4083.093750, -2456.406250),
		Vector(9667.437500, 8824.062500, -1695.562500),
		Vector(14086.875000, 12702.906250, 308.593750)
	},
	{
		Vector(15343.000000, -14101.218750, -3687.843750),
		Vector(3090.187500, -14610.000000, 161.500000),
		Vector(-1615.718750, -13135.656250, 3484.250000),
		Vector(-3578.406250, -8171.250000, 2615.218750),
		Vector(-1335.062500, -3167.093750, 931.812500),
		Vector(314.218750, 98.031250, 331.437500),
		Vector(1342.468750, 1744.281250, -594.250000),
		Vector(4290.593750, 4882.125000, 149.718750),
		Vector(6731.125000, 7896.468750, -328.937500),
		Vector(10101.156250, 12300.906250, 1497.062500)
	},
	{
		Vector(-3925.625000, -15653.281250, 972.125000),
		Vector(-3676.500000, -12469.875000, 1223.781250),
		Vector(-3040.500000, -9618.718750, 1089.156250),
		Vector(-2001.187500, -5904.000000, 540.031250),
		Vector(-948.812500, -2866.562500, 281.968750),
		Vector(583.031250, 162.593750, 386.062500),
		Vector(2049.750000, 4252.625000, 522.937500),
		Vector(2439.062500, 6297.687500, 34.968750),
		Vector(1875.281250, 11307.375000, -816.343750),
		Vector(-4920.781250, 14930.218750, -1809.000000),
		Vector(-15501.468750, 14143.625000, -338.531250)
	},
	{
		Vector(-10208.437500, -13681.906250, 9027.250000),
		Vector(-6767.937500, -13426.375000, 6031.531250),
		Vector(-3496.218750, -11199.500000, 3744.968750),
		Vector(-2612.875000, -8468.593750, 2802.062500),
		Vector(-1198.187500, -4024.250000, 1261.093750),
		Vector(-281.125000, -1332.875000, 454.000000),
		Vector(1368.312500, 2794.875000, 164.937500),
		Vector(2272.375000, 6723.281250, 626.625000),
		Vector(1808.531250, 9435.437500, 1804.000000)
	},
	{
		Vector(-15484.812500, 3573.968750, 8200.562500),
		Vector(-14034.343750, -2870.875000, 5367.156250),
		Vector(-9963.718750, -8778.968750, 3127.343750),
		Vector(-4448.968750, -8208.500000, 2284.562500),
		Vector(-1454.750000, -3385.187500, 978.843750),
		Vector(1128.593750, 1187.437500, 394.218750),
		Vector(2252.406250, 5955.812500, 29.593750),
		Vector(654.843750, 11477.687500, -1119.500000),
		Vector(-2899.468750, 15004.500000, -2288.593750)
	},
	{ // new
		Vector(15204.375, -14326.65625, -778.65625),
		Vector(12280.78125, -11007.4375, -1297.75),
		Vector(10048.4375, -8606.84375, -1401.15625),
		Vector(5892.375, -4804.28125, -894.34375),
		Vector(3558.3125, -3051.375, -556.4375),
		Vector(2069.125, -1939.25, -333.15625),
		Vector(402.25, -627.25, 183.875),
		Vector(-3716.375, 2021.4375, 755.28125),
		Vector(-6218.71875, 4586.53125, 379.9375),
		Vector(-5485.59375, 8699.15625, -269.46875),
		Vector(-1118.875, 10033.9375, -25.46875),
		Vector(6749.9375, 11353.84375, 655.5),
		Vector(10233.28125, 10134.0625, 1083),
		Vector(15801.625, 8511.96875, 1551.84375),
	},
	{ // new
		Vector(-9479.875, -12377.90625, -940.15625),
		Vector(-6607.09375, -7653.53125, -960.625),
		Vector(-3510.34375, -4071.0625, -491.3125),
		Vector(-1288.75, -1761.5625, -235),
		Vector(49.9375, -568.65625, -454.59375),
		Vector(3720.28125, 1177.28125, -320.28125),
		Vector(6142.65625, 2719, 322.6875),
		Vector(8979.78125, 6507.71875, 1261.34375),
	},
	{ // new
		Vector(11986.40625, -15594.90625, 1643.6875),
		Vector(9666.9375, -12968.96875, 1047.65625),
		Vector(7550, -10412.28125, 512.15625),
		Vector(3779.6875, -6217.90625, 228.21875),
		Vector(2041.53125, -3643.53125, 120.1875),
		Vector(427.5625, -952.25, 170.875),
		Vector(-1267.53125, 2188.8125, 35.1875),
		Vector(-1671.84375, 5637.96875, -748.5625),
		Vector(-1267.84375, 9569.09375, -670.46875),
		Vector(261.9375, 14539.34375, -754.34375),
	},
	{ // new
		Vector(4892.4375, -15749.0625, 8729.3125),
		Vector(4875.96875, -13932.03125, 3703.71875),
		Vector(3594.875, -9955.15625, 442.125),
		Vector(2409.90625, -6540.71875, -159.40625),
		Vector(1112.84375, -3183.5625, -76.53125),
		Vector(56.40625, -542.9375, 479.71875),
		Vector(-780, 1504, 680.90625),
		Vector(-1403.28125, 4540.28125, 327.28125),
		Vector(-1915.40625, 7440.3125, -473.65625),
		Vector(-3029.5625, 9996.875, -934.21875),
	},
    // Right
	{
		Vector(-15795.375000, 588.093750, 3429.437500),
		Vector(-12315.687500, 505.281250, 2886.187500),
		Vector(-7289.968750, 235.531250, 1708.093750),
		Vector(-3769.187500, 86.687500, 806.750000),
		Vector(-990.562500, -104.375000, -190.656250),
		Vector(1603.156250, -637.156250, -939.531250),
		Vector(6412.843750, -3143.718750, -131.937500),
		Vector(9450.718750, -8884.843750, 1191.968750),
		Vector(6953.312500, -14156.187500, 1843.000000)
	},	
	{
		Vector(-9850.843750, -15064.843750, 3248.250000),
		Vector(-9952.125000, -10844.781250, 2837.375000),
		Vector(-9850.062500, -7225.062500, 2687.656250),
		Vector(-7808.906250, -3230.468750, 1797.375000),
		Vector(-5080.875000, -1595.187500, 985.625000),
		Vector(-2395.406250, -636.625000, 420.468750),
		Vector(566.500000, 587.500000, -738.187500),
		Vector(5693.031250, 2146.968750, -305.562500),
		Vector(10523.000000, 5882.968750, 1052.312500),
		Vector(13347.593750, 13450.843750, 1166.375000)
	},	
	{
		Vector(-10740.562500, 15299.875000, 3185.687500),
		Vector(-11049.750000, 12716.812500, 2717.625000),
		Vector(-10658.875000, 9294.343750, 2265.031250),
		Vector(-8662.125000, 6022.531250, 1613.750000),
		Vector(-6500.343750, 3678.312500, 1028.062500),
		Vector(-4259.156250, 2265.250000, 719.687500),
		Vector(-1908.718750, 1014.218750, 281.093750),
		Vector(268.656250, -11.625000, -492.156250),
		Vector(2809.250000, -1571.468750, -1422.125000),
		Vector(5348.156250, -4116.937500, -1151.750000),
		Vector(8547.937500, -6320.156250, -1061.875000),
		Vector(13758.937500, -6926.500000, -2209.125000),
		Vector(13758.937500, -6926.500000, -2209.125000)
	},
	{
		Vector(-15151.281250, 6339.468750, 455.562500),
		Vector(-11392.156250, 4739.687500, 327.531250),
		Vector(-7025.906250, 2844.062500, 203.906250),
		Vector(-2745.750000, 1033.937500, 71.281250),
		Vector(1217.343750, -707.343750, -603.281250),
		Vector(4431.562500, -2987.968750, -1191.375000),
		Vector(9486.750000, -7992.843750, -1275.000000),
		Vector(14002.312500, -14007.000000, -952.375000)
	},	
	{
		Vector(-15315.437500, -4621.968750, -1208.593750),
		Vector(-11688.187500, -3555.968750, -1076.406250),
		Vector(-7944.500000, -2442.625000, -788.656250),
		Vector(-4691.093750, -1593.625000, -499.343750),
		Vector(-575.781250, -826.000000, 570.500000),
		Vector(3770.656250, -131.687500, 1281.500000),
		Vector(11533.000000, -2421.031250, 2013.968750)
	},	
	{
		Vector(-15710.062500, -3473.062500, -1025.968750),
		Vector(-11749.125000, -2310.812500, -1022.312500),
		Vector(-8471.281250, -1383.468750, -671.062500),
		Vector(-4902.781250, -738.781250, -387.218750),
		Vector(-1190.906250, -49.375000, 445.625000),
		Vector(2433.468750, 234.000000, 1238.375000),
		Vector(8702.468750, 561.468750, 1657.781250),
		Vector(12049.312500, -533.531250, 2164.781250),
		Vector(13966.000000, -2527.437500, 2059.343750)
	},
	{ // new
		Vector(-15363.375, 12827.875, -4416.0625),
		Vector(-12017.03125, 9644.75, -4523.875),
		Vector(-9889.21875, 7884.96875, -3434.78125),
		Vector(-6707.5, 5188.84375, -1764.65625),
		Vector(-3389.53125, 2575.53125, -760.78125),
		Vector(-1465.8125, 1147.59375, -354.65625),
		Vector(215.5, -430.5625, 713.3125),
		Vector(2147.34375, -2261.03125, 1315.4375),
		Vector(6234.8125, -6359.125, 2222.34375),
		Vector(11932.875, -10215.25, 475.34375),
	},
	{ // new
		Vector(-15912.84375, -10614.6875, 6094.84375),
		Vector(-10273.71875, -5872.15625, 3909.21875),
		Vector(-7349.71875, -3358.9375, 2605.71875),
		Vector(-3887.96875, -1469.96875, 1297.15625),
		Vector(-499.15625, -33.375, 390.96875),
		Vector(3363.78125, 1230.0625, -18.09375),
	},
	{ // new
		Vector(-15242.125, -6941.625, 4959),
		Vector(-11909.71875, -5528.625, 3892.78125),
		Vector(-3711.59375, -1653.71875, 1245.28125),
		Vector(-477.21875, -243.625, 430.8125),
		Vector(2709.09375, 1418.78125, 379.90625),
		Vector(5111.65625, 3968.5625, 552.5),
		Vector(7956.5, 6882.34375, 1147.90625),
		Vector(10801.09375, 9642.625, 1706.125),
		Vector(11046.9375, 12305.84375, 1408.65625),
		Vector(9703.875, 15786.3125, 783.59375),
	},
    // Back
	{
		Vector(-2992.812500, 14983.187500, -1132.218750),
		Vector(-1672.375000, 7975.875000, -509.781250),
		Vector(-493.687500, 2586.093750 -178.750000),
		Vector(-1558.031250, -1480.718750, -479.031250),
		Vector(-4201.781250, -3448.562500, -485.500000)
	},
	{
		Vector(-1171.343750, 14967.718750, -462.656250),
		Vector(-734.750000, 10157.312500, -504.531250),
		Vector(-251.375000, 3603.312500, -150.031250),
		Vector(48.125000, 215.593750, -395.375000),
		Vector(-1261.750000, -1642.093750, -481.718750),
		Vector(-4131.281250, -3625.312500, -471.250000)
	},
	{
		Vector(582.781250, 15171.593750, -1219.125000),
		Vector(505.593750, 9993.781250, -15.718750),
		Vector(374.875000, 6985.687500, 234.375000),
		Vector(126.625000, 1895.781250, 23.437500),
		Vector(478.781250, -620.000000, -462.031250),
		Vector(270.500000, -3017.906250, -556.718750)
	},
	{
		Vector(2705.500000, 15120.718750, 56.125000),
		Vector(1800.343750, 9573.750000, -316.375000),
		Vector(487.218750, 2746.500000, -63.875000),
		Vector(-26.562500, -905.687500, 816.718750),
		Vector(-1053.218750, -8748.406250, 1987.125000)
	},
	{
		Vector(-496.125000, 15005.593750, 1106.343750),
		Vector(-217.062500, 6649.750000, 540.812500),
		Vector(-75.875000, 2266.531250, 133.593750),
		Vector(-1332.281250, -256.250000, 552.500000),
		Vector(-4166.156250, -7751.562500, 1849.062500)
	},
	{
		Vector(-2372.500000, 14946.406250, 1196.968750),
		Vector(-1305.218750, 8083.968750, 718.656250),
		Vector(-426.750000, 2773.906250, 255.750000),
		Vector(-104.062500, -420.687500, -663.500000),
		Vector(-354.500000, -2410.343750, -679.437500)
	},
	{ // new
        Vector(8438.09375, 15864.75, -3797.78125),
        Vector(5853.1875, 11346.4375, -3219.1875),
        Vector(3471.5625, 7233.875, -2079.84375),
        Vector(1742, 3628.84375, -1066.21875),
        Vector(564.375, 1243.46875, -421.96875),
        Vector(-763.15625, -765.75, -609.03125),
        Vector(-5478.3125, -3902.21875, -1740.28125),
        Vector(-11406.125, -2233.21875, -2194.28125),
        Vector(-15458.65625, 2958.375, -2044.34375),
        Vector(-13652.25, -2336.03125, 902.75),
	},
	{ // new
		Vector(-10496.78125, 15942.46875, 2082.0625),
		Vector(-6701.875, 13684.71875, 484.6875),
		Vector(-4832.21875, 11473.59375, 80.25),
		Vector(-3410.28125, 8371.84375, -32.21875),
		Vector(-1724.78125, 3876.71875, -43.90625),
		Vector(-379.09375, 1325.34375, -280.78125),
		Vector(743.75, -1849.34375, -479.71875),
		Vector(3497.59375, -5967.90625, -320.03125),
		Vector(8342.03125, -10100.78125, -46.15625),
		Vector(15630.46875, -12735.1875, -371.96875),
	},
	{ // new
		Vector(1996.34375, 16012.03125, -6656.5625),
		Vector(1446.59375, 13269.53125, -5791.4375),
		Vector(1024.84375, 9483.625, -4171.125),
		Vector(697.875, 6667.09375, -2800.34375),
		Vector(394.4375, 3649.375, -1433.53125),
		Vector(80.125, 616.625, -496.65625),
		Vector(-1019.9375, -2547.15625, -16.6875),
		Vector(-1975.90625, -4824.6875, 525.96875),
		Vector(-5399.6875, -7877.84375, 1576.71875),
	},
    // Left
	{
		Vector(16255.656250, 3758.875000, 2120.562500),
		Vector(13493.968750, 3099.375000, 1595.812500),
		Vector(10396.468750, 2353.906250, 1100.656250),
		Vector(7212.375000, 1557.562500, 759.843750),
		Vector(4026.281250, 765.656250, 429.531250),
		Vector(1678.656250, 194.781250, 122.343750),
		Vector(-545.343750, -463.343750, -625.375000),
		Vector(-2996.125000, -1177.218750, -847.843750),
		Vector(-6284.156250, -2390.312500, -213.593750),
		Vector(-8542.687500, -3296.937500, 236.718750)
		
	},
	{
		Vector(11170.843750, -15208.687500, 2126.906250),
		Vector(11543.625000, -10653.500000, 1937.281250),
		Vector(12235.250000, -4356.562500, 1768.781250),
		Vector(12805.062500, -803.437500, 1699.000000),
		Vector(11243.343750, 3264.687500, 306.468750),
		Vector(7527.281250, 4030.625000, 29.656250),
		Vector(4935.875000, 2708.500000, 24.812500),
		Vector(2224.843750, 1116.000000, 87.468750),
		Vector(361.968750, 492.062500, -230.500000),
		Vector(-2827.312500, -313.187500, -155.281250),
		Vector(-7062.500000, -2329.375000, 1239.593750),
		Vector(-10322.156250, -1623.656250, 2073.468750),
		Vector(-10943.343750, 3532.093750, 2439.593750)
	},
	{
		Vector(16017.593750, -3611.781250, 1179.812500),
		Vector(11757.156250, -2245.781250, 1009.375000),
		Vector(5710.718750, -873.312500, 458.937500),
		Vector(1849.687500, -129.843750, 267.062500),
		Vector(-2167.562500, 560.656250, 554.125000),
		Vector(-5485.343750, 2451.031250, -457.375000),
		Vector(-7846.843750, 7028.000000, -1361.312500)
	},	
	{
		Vector(10949.375000, -14981.625000, 4130.718750),
		Vector(11322.406250, -10315.968750, 4059.500000),
		Vector(9157.093750, -5526.812500, 2855.000000),
		Vector(4602.187500, -2554.125000, 1366.250000),
		Vector(1980.000000, -1114.406250, 681.250000),
		Vector(-2229.968750, 1119.562500, 515.312500),
		Vector(-8505.187500, 3519.468750, 1621.937500),
		Vector(-15171.968750, 5114.656250, 3153.937500)
	},
	{
		Vector(10020.406250, -15616.125000, 4318.218750),
		Vector(10417.250000, -13880.468750, 3950.218750),
		Vector(10158.937500, -9256.531250, 3160.625000),
		Vector(6034.000000, -5253.437500, 1597.156250),
		Vector(2981.968750, -2616.593750, 735.343750),
		Vector(700.312500, -523.593750, 456.281250),
		Vector(-2889.125000, 2196.187500, 75.500000),
		Vector(-8093.281250, 3155.406250, -967.343750),
		Vector(-13520.062500, -362.937500, -1071.000000)
	},
	{
		Vector(12838.312500, -13691.437500, 4318.218750),
		Vector(13510.593750, -10503.437500, 4071.156250),
		Vector(13161.937500, -6605.843750, 3370.875000),
		Vector(12237.156250, -2375.718750, 2717.156250),
		Vector(9331.281250, 132.718750, 1581.937500),
		Vector(5242.125000, 360.593750, 814.812500),
		Vector(2025.812500, 206.281250, 301.343750),
		Vector(-1846.062500, -555.531250, 641.187500),
		Vector(-5730.468750, -1030.906250, 1511.312500),
		Vector(-11093.312500, -689.312500, 1900.968750),
		Vector(-14034.875000, 2233.562500, 927.468750)
	},
	{ // new
		Vector(159.40625, -15525.46875, 151.9375),
		Vector(3320.375, -14264.21875, -341.75),
		Vector(8459.34375, -11626, -1142.9375),
		Vector(13090.6875, -6334.25, -1704.625),
		Vector(13601.125, 1543.25, -1798.28125),
		Vector(7538.125, 2752.6875, -479.03125),
		Vector(2569.34375, 1084.84375, -141.59375),
		Vector(-1054.46875, 287.0625, -601.0625),
		Vector(-4513.0625, -1376.34375, -419.125),
		Vector(-10452.65625, -9714.03125, -833.8125),
	},
	{ // new
		Vector(16067.375, -7299.28125, -3760.78125),
		Vector(12111.09375, -3596.6875, -3124.3125),
		Vector(7691.1875, -2285.4375, -2030.4375),
		Vector(2812.34375, -550.96875, -682.1875),
		Vector(601.8125, -272.1875, -527),
		Vector(-777.375, 62.78125, -708.8125),
		Vector(-2120.15625, 232.1875, -872.03125),
		Vector(-5094.4375, 1683.65625, -1089.25),
		Vector(-7572.03125, 4267.5625, -1161.90625),
		Vector(-9826.34375, 8345.65625, -1367.71875),
	},
}