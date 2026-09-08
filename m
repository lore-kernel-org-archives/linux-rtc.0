Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013047.outbound.protection.outlook.com [52.101.83.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3242330FC27;
	Tue,  8 Sep 2026 11:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788867905; cv=fail; b=HeT6SDKyVt84ttpszfjA1SgCWCQwceZkKQoBPP6LycAnNPW/ypC7LOV/KYPSRS4nRzkQDxMMRI2NF0l3n1XCa1LpRhMpXoX+SyBSnGB69/vMdmkPEMVwphUlv8rTMbMWX3aIEwotJ4fZXa1T1YPR7SuLw4ZyEaTMaFBX/CNhPwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788867905; c=relaxed/simple;
	bh=I0WmnJJIWGVubI+x38yRE/A/NVm49owH68yFGGEWUN0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hx4YgCqdVVnXYoyOrjgQpDpDXacguH5VTRkTDc1uBbJG5hQBVpkmhR8mc80v4yxz93R0xvnfI+itL8za+oKSJLPUW4UI48/cnvq8/ppdD4BD6hg2CQkF7XY+n2RU3b13vlTJy/9Qiz41Od4s1iPh1o4+yWdCkH59XW3dAI0OeSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=sBxt693c; arc=fail smtp.client-ip=52.101.83.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="sBxt693c"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZbfrQ3n3vadWel3zI5Qg3lIGcFJkyhO3NGJcguxGTh1CWJloP2uC+hC0Km6CflvXBWLylORTcQSyAZE6FC3EhXYrCEVwRHWTuq9P1xMMa3LujmJAbsZEkyACDgiP8mYTjoPyPHPdFnp8rGivWexgal8maWe7bHPU5JOVlFnP1T45qCzMJi/PypCg8l1wuF24V2x2juZtHgVYhKr9eGrRzh4FQhiohFhtbfQGG67NkSvhVd0ydbvgErdaKus42Tm3vm4nHR3oCoaPpFzUKn5+K3tBLNm5sr7u9SwGprj0KaI/QDVdZkRzfUIYq80xsmtirbTVJ1mZU12fpGIYE2u1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0WmnJJIWGVubI+x38yRE/A/NVm49owH68yFGGEWUN0=;
 b=ApBXqWHfNnj1eI3RJgO4AA8WHQtdDo8wEmgvPH5hP7wWf+JC4xAB9II3PBTm56tgYqOntohTEWWGJYxi1YDlboImEV6DcMh3EKTT3IjWbZXe4rgu4C0S0ID4dzItw4EwLh04t3AVglBqJYZV6U9/nZx58fS02LQ0J3dIOZoBy9vuC/Q+En2TkLItt0xS7WDOfm+FCue832oevN3XyZmj8fUKZZ+2kdGHfyIsZ75hg/sCYarEUqmYEKzsXeZIE9dLyucp02d4FMWj6L0BZ0fm7ktCo5/5WBYUlNrxP0+Y3YHrAAgep64sfqJxJTX4pODJsM9FMPAhjnVs0DwCMiCwrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I0WmnJJIWGVubI+x38yRE/A/NVm49owH68yFGGEWUN0=;
 b=sBxt693c52MdA+MwYQoOBC4OQFt9cJio813dM/u1eKoHEq1hm27D00LkVpJP54etg2pWTxhsh1HZOoGEAAvjSwDW8H7pjI4qK1UO1fRVnAjnOeFk37wXldyi8ihNMeE+C4hmffiBk6YyvJ/USNEdHze6+WbOoujQBtt42Bj/O3OfJv4Cl6LItrPAxdbXxvQxVQERWu7eRCSu3/oI+KupR7lp6nAStsyA6hbJHuAs38NuTyp0Uf+WaiZ72nAgU5lBOSWl3QhW5SPIsdrtRx0ziM1WsnvRWzfSDL9qlWwsQmCrOwSKd/TIsULzOd85pJfj9fqN+Mdu0UCeaTZ3Yqc1vQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by DB9PR10MB5380.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:333::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 11:44:53 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 11:44:52 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
	"matti.vaittinen@fi.rohmeurope.com" <matti.vaittinen@fi.rohmeurope.com>,
	"matti.vaittinen@linux.dev" <matti.vaittinen@linux.dev>
CC: "mfd@lists.linux.dev" <mfd@lists.linux.dev>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "linux-rtc@vger.kernel.org"
	<linux-rtc@vger.kernel.org>
Subject: Re: [PATCH v3 10/10] MAINTAINERS: Add ROHM BD73800 PMIC files
Thread-Topic: [PATCH v3 10/10] MAINTAINERS: Add ROHM BD73800 PMIC files
Thread-Index: AQHdOsvpv94NpYj+pECrKCLkG8+H1LbEmVKA
Date: Tue, 8 Sep 2026 11:44:52 +0000
Message-ID: <b7780772767508f33156ee64f785f4d0090f78b9.camel@siemens.com>
References: <cover.1788346553.git.mazziesaccount@gmail.com>
	 <cfea698c783274d26858e85d4ca7068eba3d3ef9.1788346553.git.mazziesaccount@gmail.com>
In-Reply-To:
 <cfea698c783274d26858e85d4ca7068eba3d3ef9.1788346553.git.mazziesaccount@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|DB9PR10MB5380:EE_
x-ms-office365-filtering-correlation-id: 3a09037e-e4c0-4371-8cc2-08df0d9e986f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|38070700021|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003|55112099003;
x-microsoft-antispam-message-info:
 MUli2TPDFa55iimFcTlot1TK31rCt68XcbBH+S60sJCRkpjOSBBWZjFMCQ1cVQ0m2r+KjZqiQq+4JIJKExTLvs2bGwjkC6ZzeWNtntZJsstthKj697D92bybiie6X7CaMN5IJxqfUB09jwx9ILnYNrho7nO/bx68TPeYYZtZHKgVD1H3yVe/vG2ThRxZ75i2nD+2+g0lRiH18pV/pk5ChQnPy8ASEXYg3aLTCG5SByX96ew7nItSeWaUdu1bRwdfz78aXllDwkcyUQZnUagDP9IXo0oqLJaKOq725DzfSS0vHLjCeqXzxPSh7zzLMc9dBUDArBjB45IZnjqVKDi7LtL6LZuKyqK7JVjsGesYNqu3spFqnylYxxGdKQqX4sdAIsztTa2JnZUrWeqPcuN/CqbNcwbAg3WugjD2o0oyTHo0LF4Z2Rgu2NzV6u3XAoOrXrPWf0OQ2TXJYfLNj3uah6yuwmNwUk/ep8eD6go2y9X+0FoGxIH7yibqZTbwS5zbIRMXJTHwaGP3TKTl/bZ80EIfnUtzBsAxKsnyE1YUcT+YbpECwmX47hBBtRUlE1Q5yWy8JzNOgX1gma+8rhk4HzUpwpGKuehR72hcML/Gf7zSesIg0ExEPVnjSdDzvvVZUyfvhNrO3Mhkvzv5X5v3urTrWjOh3koaC95mpxP2QrY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(38070700021)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003)(55112099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L29GWGNsZTc5WnUveDJzTGlyRGppR3hERno0SkVaWlhJd1hoQ2p5RlZkc3Vh?=
 =?utf-8?B?OGtibDhhQitXN3NMQW93NXBHUGFCcnZmL2FCNlE3ckJNajI5a1FTRWZvNi9N?=
 =?utf-8?B?a1pBcmM2Y25iU1FXL1RBWTRacDcrclBnTG03K1ZicFNmYWFIYXVRMkU5ekx0?=
 =?utf-8?B?b25Sd0ZuUFlvWEp0Q2J0V25ma282alB5Lzg4ZzhkTVBWK0pDaEh3MUc4TUdP?=
 =?utf-8?B?MUkvaGpuTEdVRDF1Z0J6aDBNNy95bmFUWlJGd1VOVmluNElQZjUvTnlNeGY2?=
 =?utf-8?B?bU9WRkF4WmhBQXdkaFRQYk9KT1JtSUgvQmlPU1AvK0hubzhaUjlIc2dMelBT?=
 =?utf-8?B?WUo0RjhuK2Y1QXJHcC8xblZZazZZT1MyWmdIV25oRUkxcG9ORGhZV2xxeVR6?=
 =?utf-8?B?bDkwOVVxMm5pT3VDajdvdFF1VmtqQjVMdmFsaDBWK2x4VzVuVWRFTFJtVkZo?=
 =?utf-8?B?TVYrZS9IZ0VvM0xISjMwU1FsTlh2ZGQ5YWM0Z0VweDYwZDltMjFORDhGaFBy?=
 =?utf-8?B?TWU4TjE4NmozUUh4OEN2cUxieFRQN1I4R1EvQitoTEU0NTQ2L3JRcEk0ZVFu?=
 =?utf-8?B?M21hYWloSStZVDZKV2lEYWhsMWpoSzNBRVpFYzMzeWRwR1ZoODJZNlNxbXFC?=
 =?utf-8?B?cGx6YlhEVk5nRFhHOXBRdFJQcVNuYWc1d2MwdHpDdWpHWFVyS3ZYTWx6Sm5K?=
 =?utf-8?B?MGdmUUtSOEY3VXBPTXFOV24rM1dxQmJ5Y3o2VlRLb2xMci84QjBRTTRFbWho?=
 =?utf-8?B?M3B0UVhwdnFHRFpzMW1tbElLK1ZITDM0VjdPbWdtR3p1VTQwQjU5UlBhNDdH?=
 =?utf-8?B?bktSWmw0aktLMlV0NmtIWm8weDVYYVJ3YzEvYmJTRjMrc0ZRNlZuSlJsQkth?=
 =?utf-8?B?akRVQWRUS0cyWFQ2am5uelBQdWxsSGRGRG0xdkdHU3FJTldTWkpjRlJNQlRL?=
 =?utf-8?B?Rnh0ZVFaK2hJeVVjSUxNLzRvYTRuWG1USlh5YzVSUUN6WTJqZTBnUUVlMTQz?=
 =?utf-8?B?SHdPbmkzcHZtZVBQVDYzLzJVQWlNcGFOc3Y2bUF5czgwR3BvRWRtN1dZZ3Fp?=
 =?utf-8?B?MUhQcm5tREVCT1Axd2pTSjdac0V6WHZZUGZFOFNTc2RqdkRJZkhOWmZSSXQz?=
 =?utf-8?B?dDExa08va3ZGNmVhZmxYNnBWcUJMSmlyRnQ2N2NVMlcwVzNMK3RScmpsNzhk?=
 =?utf-8?B?cGZWdnJlaysrUUduUmRhdEsvVFFJaUUxM0xMRUJVSDZqSTladTdLTkZYQklF?=
 =?utf-8?B?UnhSNktjaUhHVVVYWkRuQ1hwZ2pyTnU5djBaVDg4N2dCenh1OFNJa2NCY3lw?=
 =?utf-8?B?ZUhJbmcwTTJRTTNsVS92RUo5WlZJaDI0K0NnVUE3RnptYUhmbCtkVWhHV0U3?=
 =?utf-8?B?ZW1KeDFZaDVjeE50cHF4KzBjNURoTkdKWG9hSklaNUN1ZERqbmlMQTNHM3N6?=
 =?utf-8?B?L3Z4SVpmaVMwbGRPTmhOSGJlN1RtZzBnNWIvNzVOVHJ6dTExck1QYnBVUmR6?=
 =?utf-8?B?MzdockhlelhqSHJUbHU0QzFnVlFJc3p5VTBxaXdhZzlQdHJ3cUMzeDcwa0xq?=
 =?utf-8?B?Ny9UT1ppRk5VUkU4ZzZhdHFHbTloR1pPRlF2UUZ6ZnBRZm9vMzB0SVFYS1Fq?=
 =?utf-8?B?MUlLQm91ay9HUlBKVWVlNHRkUmZRSExDYUdWZ0E5ditHUWxGb1lScGdQeWdS?=
 =?utf-8?B?aWpzNUtLL1J3a2I4bktpWmlDRzQ5aGJveENaNHpJRTdFOFYrbjZwdXRHSUNt?=
 =?utf-8?B?VjM3dlhMUzdPSGIxbnRZYk1YelRjU2NlWHE3MzBBVmxUSGRTSjh0QmVVNklV?=
 =?utf-8?B?WjlSU085cmVnRG5IRURmMWxNdkdzc0NHZTRrcDVaZjRkUDRBTms5TUJkMk9T?=
 =?utf-8?B?Zk15RzBpakorN0N6Y2FzL01UODlxVFdpanM3ck9sQ1ZvSmhFbnA2dTZ2bmky?=
 =?utf-8?B?T0RRWm5VTERyYVVmbjg2L3pXVHhEZFNoV1BjZG81ZkFpTkRyaGd1M3dyOGNN?=
 =?utf-8?B?dGNTME5CU1VYbDFOLzZFcThPOEQ1b1RJL2NwZ3J4VGlIT2k5c3NsUFdBUkNl?=
 =?utf-8?B?ajR1emFnTVhNTDN1QlUrZWZzanUyRi9ZL3E4V2c0aUg1elk3bkNQSDRrTUFl?=
 =?utf-8?B?bnVNaURkSnMyeWhoa1g5QkR2UUJVa0J2MG9GTWVmVmI4UGJ5RFpWTXdkZWU0?=
 =?utf-8?B?U3c4ZXprTlZma2E4bUhjNmFiRFhQTnI3TVZFMnFKOWJ2dGxvYTdWc1VFcFlZ?=
 =?utf-8?B?V2tHbWx0dnRLaDdXR2dVbHplelRIVisvaEZOQ3JBb3c5cStySkpVTEVTMUQ5?=
 =?utf-8?B?cXF6OUZvdFY2ME15VW4rdC9PRXVWOWpsMGZqSlRNUDJETjJwdTVERDV2OUpv?=
 =?utf-8?Q?sA0MFbVwhq0dKGJE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <796E869BA22D8C4AB7ADD1FA471C8F58@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a09037e-e4c0-4371-8cc2-08df0d9e986f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 11:44:52.2697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pspuv28OOvaXAK2BleZUePHEamrumkXSErq74iLk2ytqbnoYhbKdU/0SJM3nQK5tO/HQs9C/fjB4oz9tH6KtTRdhEKbm/suAo2CZWUhlpFg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB5380

T24gV2VkLCAyMDI2LTA5LTAyIGF0IDE0OjA3ICswMzAwLCBNYXR0aSBWYWl0dGluZW4gd3JvdGU6
DQo+IEZyb206IE1hdHRpIFZhaXR0aW5lbiA8bWF6emllc2FjY291bnRAZ21haWwuY29tPg0KPiAN
Cj4gQWRkIHRoZSB1bmRlcnNpZ25lZCBhcyBhIG1haW50YWluZXIgZm9yIHRoZSBST0hNIEJENzM4
MDAgUE1JQyByZWxhdGVkDQo+IGZpbGVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWF0dGkgVmFp
dHRpbmVuIDxtYXp6aWVzYWNjb3VudEBnbWFpbC5jb20+DQoNClJldmlld2VkLWJ5OiBBbGV4YW5k
ZXIgU3ZlcmRsaW4gPGFsZXhhbmRlci5zdmVyZGxpbkBzaWVtZW5zLmNvbT4NCg0KPiAtLS0NCj4g
UmV2aXNpb24gaGlzdG9yeToNCj4gwqB2MSA9PiA6DQo+IMKgIC0gTm8gY2hhbmdlcw0KPiAtLS0N
Cj4gwqBNQUlOVEFJTkVSUyB8IDIgKysNCj4gwqAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KPiBpbmRl
eCAzYTE5ZGE3NGQwMGMuLmIwOTI1ZmEyMTJjYyAxMDA2NDQNCj4gLS0tIGEvTUFJTlRBSU5FUlMN
Cj4gKysrIGIvTUFJTlRBSU5FUlMNCj4gQEAgLTIzODIxLDYgKzIzODIxLDcgQEAgRjoJZHJpdmVy
cy9jbGsvY2xrLWJkNzE4eDcuYw0KPiDCoEY6CWRyaXZlcnMvZ3Bpby9ncGlvLWJkNzE4MTUuYw0K
PiDCoEY6CWRyaXZlcnMvZ3Bpby9ncGlvLWJkNzE4MjguYw0KPiDCoEY6CWRyaXZlcnMvZ3Bpby9n
cGlvLWJkNzI3MjAuYw0KPiArRjoJZHJpdmVycy9ncGlvL2dwaW8tYmQ3MzgwMC5jDQo+IMKgRjoJ
ZHJpdmVycy9tZmQvcm9obS1iZDcxODI4LmMNCj4gwqBGOglkcml2ZXJzL21mZC9yb2htLWJkNzE4
eDcuYw0KPiDCoEY6CWRyaXZlcnMvbWZkL3JvaG0tYmQ5NTc2LmMNCj4gQEAgLTIzODQwLDYgKzIz
ODQxLDcgQEAgRjoJaW5jbHVkZS9saW51eC9tZmQvcm9obS1iZDcxODE1LmgNCj4gwqBGOglpbmNs
dWRlL2xpbnV4L21mZC9yb2htLWJkNzE4MjguaA0KPiDCoEY6CWluY2x1ZGUvbGludXgvbWZkL3Jv
aG0tYmQ3MTh4Ny5oDQo+IMKgRjoJaW5jbHVkZS9saW51eC9tZmQvcm9obS1iZDcyNzIwLmgNCj4g
K0Y6CWluY2x1ZGUvbGludXgvbWZkL3JvaG0tYmQ3MzgwMC5oDQo+IMKgRjoJaW5jbHVkZS9saW51
eC9tZmQvcm9obS1iZDk1N3guaA0KPiDCoEY6CWluY2x1ZGUvbGludXgvbWZkL3JvaG0tYmQ5Njgw
MS5oDQo+IMKgRjoJaW5jbHVkZS9saW51eC9tZmQvcm9obS1iZDk2ODAyLmgNCg0KLS0gDQpBbGV4
YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
