Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010056.outbound.protection.outlook.com [52.101.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBB55328BE;
	Tue,  8 Sep 2026 12:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788868895; cv=fail; b=KPfLvDWbA5kVJkvZXdzpt7l6jt9nuIXvvCYKnupBUWRmt7oUF3hZVYKycykmQu0oohZTJwXz5TFhqjBQkfqyUBOPBF3uPVuqds+pKRvcXVu9tmWMajCiXKVeS6aIrFxWtk+bO85nZ8sPSRYlqclRlipRSEfeCk/bFDwQ1hd36yc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788868895; c=relaxed/simple;
	bh=HWYXAaA0PMz48DDD+P9TQOPhmtCmZJn2lda9eWSTkNk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qd0xlEjx4D1RczU95b55ORdiOJYL18h6cS9uqhmt7gPmULo0YXd35lgZI41rWM7c6AMo0jwOUbSJ7kVsyeNUIv5iVlg2Roh3O/1wauffbe7eEW49sWU4dEpdrc3fMxgmiu8ohn5AeuOsQcinQNLgw2KW7DmthGnd4WhjyCjOI2s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=BklbcLrH; arc=fail smtp.client-ip=52.101.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="BklbcLrH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VlqK13a/PQZFWSh7Jx6bXeD6l6DrHCcTNx9ZMHFY/6H0M+5b8D2guG1EDsbOCmrvA9949EHGUI9Leq44G9v8u5kKuYT1X/ZpCQbKovVSX8+01ZLNDvx4466r4lbkckbOEYe+GhUK9qrTyaGrjTaCfEJ0aKtG4O7uPFWkRF6lBPOA+AylAwmPCv/Ee/1x/5kZqGS8ZzBVP1XJv1dL1V/Vp0j/AeCXSL1EmjLlrjFX+ZtLLUWYdkA7MaGwFcPhkWTjHPWVVbc7T6ooXul8oAtPVQoFdHB7PF/DWY87FSMOmoWGXFvmUtFywrfpIOEkM2fnHv2EOkZN4AhJBevtXjlCiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HWYXAaA0PMz48DDD+P9TQOPhmtCmZJn2lda9eWSTkNk=;
 b=HZpAvEBw8HzNSkLy0xBuxIOYz7Arv41p1Ohy3+s+fyj4t52lHWC+Aie6Cp6q1/PavRzFpFBPDU33VTNfyWgzyL7ulbc33AYo7nDl/vxLuHZsHJFbk+gj7nAIZDSj+RaI0B7MSla/v2PuM8hDqykwAZ9tLQQx2TtFM0H/WK5KKXWydNDx2sIuQtgX3uIAFTT7BqTLMdgrpjoyBHC+AgQ5pYtH1zXjDNMNDASWocupzus6THZwiS/bv2Tuovqbs9mQNzN91BlVZSFSi4Y+P5A3Th728XHaHQRylBwiJyKWkXAweONj/AkDCzWJeUF+iTg593qrToKIi/qPZHvhGjWoEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HWYXAaA0PMz48DDD+P9TQOPhmtCmZJn2lda9eWSTkNk=;
 b=BklbcLrHJR3j8bxgnSN4HJd3I+fg/m8aKcMn0Afh/nMtw91rE+NMLNtxJBUUZ0pDqgFAWNQ13jdPVmapmSjPY/5TdhlhnZZYdL2/RKSLeXXB+W1hzWc+oBErC6glZrdEA5riLBPUfIQcrNdZ16Je7SfsU51XepkiOOetk8vlvXuN0++2cXELKXMI+tG3sVPCpRIVRfMMuhIO2A67gw6HBDbxklQiNyxIhc2Xox+Pp3vyXT+KDpu4v1su+r3wTGfr3TNj6w4EXUnOt5WPTrwktB1s1FTdh6DWN37lf6+j1Z/YKX+1p6nzQycRiGUGp/fBfTrdI2tVUYAVHTM+f9mNYA==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by GV1PR10MB8517.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Tue, 8 Sep
 2026 12:01:30 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 12:01:29 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
	"matti.vaittinen@fi.rohmeurope.com" <matti.vaittinen@fi.rohmeurope.com>,
	"matti.vaittinen@linux.dev" <matti.vaittinen@linux.dev>
CC: "mfd@lists.linux.dev" <mfd@lists.linux.dev>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "linux-rtc@vger.kernel.org"
	<linux-rtc@vger.kernel.org>
Subject: Re: [PATCH v3 08/10] clk: bd718x7: Support ROHM BD73800
Thread-Topic: [PATCH v3 08/10] clk: bd718x7: Support ROHM BD73800
Thread-Index: AQHdOsttxnBD/l6jh0mjMBVIaRCwZbbEnfmA
Date: Tue, 8 Sep 2026 12:01:29 +0000
Message-ID: <95c440507a00eca069d73c360551aac7cc35d417.camel@siemens.com>
References: <cover.1788346553.git.mazziesaccount@gmail.com>
	 <2a74fea679420d147ab1029943ff071628dc8c5a.1788346553.git.mazziesaccount@gmail.com>
In-Reply-To:
 <2a74fea679420d147ab1029943ff071628dc8c5a.1788346553.git.mazziesaccount@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|GV1PR10MB8517:EE_
x-ms-office365-filtering-correlation-id: b55ec7be-8bc4-4e39-bbc8-08df0da0eb12
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|38070700021|6133799003|3023799007|10067099003|4143699003|11063799006|56012099006|55112099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 2xAEJfn9MwqTgtpVWHYdxLp3Wh2Vp9OvXIPlYZMJwcHHZjEFwfMmb8u6PRVuQ2B5h+C4bwZPGeeAAW9Xakrs8A31KiE0KRch3sojySOUMlbvgXewNp9VRwBLxPf44yXln0WfLr2RBS0Wg9+Hu7UFc/IEbRxaJwlU13exTwoBHqcB3mkDDfDYtFj5tTs9KootGIF8g7OxGB5LpWlWs/K+3PLo17fNM0BxQ/PsKyEDDTncEjbBjKwKKHEfqwLdOv54D5Aufayhc0mdnnlcQSJpSs+PnmyAp99ad4KSv6J+h1YDx2wNB1YOlr3MMczNRwrFojuHQmS/UYKAqH5Msgy5jwr0vRt82DJ2ze95n23fZRI2fw/hYr8/pMBW9w+pTLJNPD4j3w2Ejx1/DWaE+YriR7HW0qodZqvdNuZsEyiaaV+XfiLG81uEOLSShWoOTSFlVQDUPV6sjAN2PbPG82xZTV3apXBNUwlavsnt1sMVqzm7EfSme/zhtMs8F7iPoJA8NGOKGg7H52HbiSijpNm2Q/mf6NB3nsxc1+9tTroZrOtt6dEFUXL3+JbOyDcU8z0+clD/LZmtJ2iaPGnGOsmlWcjexjV0NaunrPDxvlm9pbrPm08gkvrFw58VGcSwBZkNpMQgKHMesRRUDR7/MTzaZkoPnnQtssTX1YccRIay1Yw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(38070700021)(6133799003)(3023799007)(10067099003)(4143699003)(11063799006)(56012099006)(55112099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NGxTZFh2SVRHUXNnbnJJN3JNeXBUUDN3NkpJUFhPSDBCa29jMnQ4WW01bUNG?=
 =?utf-8?B?ZTdTa25YT3JSb29DRHpNT0RQZUZJUUxVQ3RvV3VYdjFxUjc0aEJ5aTJqQlhJ?=
 =?utf-8?B?aXlONmR3SUxhRUlJY0xpcmpNTG9lc2pLOE9RT0lCZzR2V3I2RG52U0hKWXF6?=
 =?utf-8?B?MHJudm8zNmd4WEV3OTllVG5WWEs1T2ZMdzg2OW53MjdDK1RUWjdZaTFnSXZP?=
 =?utf-8?B?UFJobUhjQ2dBRUZlL0ZTb1BiYzcxU1FEZ1p3cENwSTBOcVJIQWd3MGpKREtk?=
 =?utf-8?B?MytybmFtL0M1N0VuT1V0ODJZM0hvRmluVEV1cTBNM2hJTU9WR3B5N2g1c1or?=
 =?utf-8?B?c2VrTUk2TXUrWXI5dDR6cjNib24wNUZVTWZnbXRxNzFjZzlZSGVEaTNUS1dk?=
 =?utf-8?B?dEd6c2hlWjFRR1ZkTTVvVWlNVU5uTUhhV01heDgxMW53SGRUN2pJNGhqc09u?=
 =?utf-8?B?TmttOTlSaThmVHEvb2U1SEllQzBub2krZWg0K0I2Y25pWkYvcStQa2NFVXV4?=
 =?utf-8?B?RWsyRGZhak5BSDVPY0s3MlNzVUE0dU41QXBtMnc0N1ErTGoydHpNYUZhclBy?=
 =?utf-8?B?WEpwakFXT3hJTll2dmdVMEdwaTlxQ3A1TGo0WThSY044Mm1oUG1VUzdUUjIr?=
 =?utf-8?B?STVJWjk4dkFPVGRtcG5TM2RJNFl4ZEdDaGpqU0JYcTQyVVNjSW1OYTZmUlRN?=
 =?utf-8?B?OHNQaFhZRDhHNkJ3ZDRkMXdiUmxqZFdXVm1xWWRMUVhQQjNNbzd0eXJHeTFh?=
 =?utf-8?B?VG5PUE1QZ3crZjRoL0JRVDN6SC9uUktrTEowUlhudmEwZnBSWGZFOGdIZW5a?=
 =?utf-8?B?K2lWN3ZvdmkxNkIwNGtRSXBWL2xSa0EzdUpndzFsZ2ZXUmkvMktUQzZKa3Fx?=
 =?utf-8?B?NUNlbUhENUpKbnZRVFo3TlZON3BsVm04OWpaclMrbDc4eDZrdURFMkZrY0N0?=
 =?utf-8?B?VU1Dbzk1Nks1QW9LczVwQVRVNlBYSEhQTjF1aWVzSXVZRnQzMFg3bkRrcktq?=
 =?utf-8?B?VU1CRENmTWh3YkExdVhxaXZqa3dOZjlteTNTOFE3b3l3SVdMNnU0WGUwZWQz?=
 =?utf-8?B?ZVVtbFYvZWJvS0dxVThvRjMvUzA1OHhtYmZSakU3ZUpWQmtKeUl6SjN4bHNU?=
 =?utf-8?B?RThmb3p1U00za3VzYVFqWkhqYUx3YzZEdXVPYXJkZEVLd0lML0pjUnV4eWwv?=
 =?utf-8?B?N2Yvek5DV3dYRHZpM0JhMEFTd3g5NGtEa0NBdGVoaTFkUmV2YWlDLzBYOXMx?=
 =?utf-8?B?dElXaTRqTGdJUFBPUWVyemVCT29qWXFBZDRmWTlwS0J3Zzc4UUpOaXYxVGN4?=
 =?utf-8?B?bEt5VlJXWGxyYXhIRlJKak5wSldacklYTmQ4cHRyd1c2VU5DTFVKaERlVjJw?=
 =?utf-8?B?eVNKQWIwdzBIQ3d3ZjRVZGc2ZkdNTkFYYTRkTWt1T3BzM3E2d0llSk0wTWc0?=
 =?utf-8?B?T3RJSUp4VTBtbmhkZDl1eHN2QUh4WFFwSTJJK0tsdFJITWlIbkxTaWx0UThQ?=
 =?utf-8?B?c29JRTVDQ25tTUQ4bjhFaHRPWEhPWTdBSnc0WGZSQWphQzMrN3dOR0xjVmkv?=
 =?utf-8?B?RnlQbjFGa3BjSWVUd0sxbktnUHpEN1p5Uyt6R09MaGIxVnRkK2ZBT05NK1Rt?=
 =?utf-8?B?cVhaQ1dEOE9Xd3ZTRVk0NTl1WEt5RUxRbG5WQkd5YTRVU2xxTmIyU3hhSkQz?=
 =?utf-8?B?emFpWmdlMmd6SWtlWEtYeEVTdnF2cUFkb3loaGlDQXdRSmtleWxlTUJ5cUNl?=
 =?utf-8?B?YkpTNW40RkoxOW5JdUFRclhTUVBkd1lTSEM1U2pTc014bTdvblhqWEtCK1lE?=
 =?utf-8?B?a3hDcEZQV1JzOGtRNjkzQzFHM01MT3BSNXlwMXVOaHpDZHo4bXlPV3dtbnJB?=
 =?utf-8?B?M3VXdDZJR1QzT1hnTGlRanQxczZIS3BYQkY1U2c3ZUd3V1JZR1k1TXBmYW1v?=
 =?utf-8?B?RmRuQm1TU0FHOXdjOWcyNFBkUjdDUGYxelNCSlp4UVVLMGpCY0oySVZYcXA1?=
 =?utf-8?B?dTAvS3lmMWtLUFZqRk5VME9SR2hmOStBUndPcUtRTi8xU0NjaThiaVVLNlph?=
 =?utf-8?B?d1dzN1haYlc5NmFYSzQ1bUZBL2NCQ1dPa1Z1aUxsUTI0bFRsZHpLL3UrKy81?=
 =?utf-8?B?dk9uZ25iK05LU3VsdFRzenZqT2ZHcnovY3RCZit1WitrVGJkMkJLeTcycUZt?=
 =?utf-8?B?RkIwMTBYakI2UWxDTkVqbjI5YjY4NnNuVGFQTFY3WkpkSXYydkJySUxKOXJk?=
 =?utf-8?B?T0RHWG5Udyt4VE13RzcxUEFqYU8zWit3VGQyM0JIWG1EeFE3Ym9tQ0VoN3Bn?=
 =?utf-8?B?V05DZFY0SHlXMFN5cWl3WmxTeWdSMUFxOG5vL3RSTnFFa3ZnaVoxa09Lb1FD?=
 =?utf-8?Q?YH6xbyXP3Opouy1Q=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <202BE819E0B6774FBD1DEFA8422128BA@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b55ec7be-8bc4-4e39-bbc8-08df0da0eb12
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2026 12:01:29.9672
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZobhO5VBK1Uc5zNui+bFN3kCM5dGty13fhZxAIu/brFmiAIeWsTrUFFW25VthZcKriBLO0cmsPjSNFRoYdDMKiZE9IU/TnEZFVgCqWvCqNg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB8517

T24gV2VkLCAyMDI2LTA5LTAyIGF0IDE0OjA1ICswMzAwLCBNYXR0aSBWYWl0dGluZW4gd3JvdGU6
DQo+IEZyb206IE1hdHRpIFZhaXR0aW5lbiA8bWF6emllc2FjY291bnRAZ21haWwuY29tPg0KPiAN
Cj4gVGhlIFJPSE0gQkQ3MzgwMCBQTUlDIGhhcyBhIDMyLjc2OCBrSHogY2xvY2sgZ2F0ZS4gQWRk
IHN1cHBvcnQgZm9yDQo+IGNvbnRyb2xsaW5nIHRoaXMgY2xvY2suDQo+IA0KPiBOT1RFOiBUaGUg
Q0xLT1VUIHBpbiBjYW4gYmUgbXV4ZWQgYnkgYW4gT1RQIG9wdGlvbi4gT24gc29tZSBPVFANCj4g
Y29uZmlndXJhdGlvbnMgdGhlIENMS09VVCBpcyBub3Qgb3V0cHV0dGluZyB0aGUgY2xrIHNpZ25h
bC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1hdHRpIFZhaXR0aW5lbiA8bWF6emllc2FjY291bnRA
Z21haWwuY29tPg0KDQpSZXZpZXdlZC1ieTogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIu
c3ZlcmRsaW5Ac2llbWVucy5jb20+DQoNCj4gLS0tDQo+IFJldmlzaW9uIGhpc3Rvcnk6DQo+IMKg
djIgPT4gdjM6DQo+IMKgLSBVc2UgbmFtZWQgaW5pdGlhbGl6ZXJzIGZvciBwbGF0Zm9ybV9kZXZp
Y2VfaWQNCj4gwqB2MSA9PiB2MjoNCj4gwqAgLSBObyBjaGFuZ2VzDQo+IC0tLQ0KPiDCoGRyaXZl
cnMvY2xrL2Nsay1iZDcxOHg3LmMgfCA4ICsrKysrKysrDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDgg
aW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2xrL2Nsay1iZDcxOHg3
LmMgYi9kcml2ZXJzL2Nsay9jbGstYmQ3MTh4Ny5jDQo+IGluZGV4IDhkZGI1MGM2Nzc1Ny4uMTY5
OGI3NjNiY2I3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2Nsay9jbGstYmQ3MTh4Ny5jDQo+ICsr
KyBiL2RyaXZlcnMvY2xrL2Nsay1iZDcxOHg3LmMNCj4gQEAgLTIxLDYgKzIxLDkgQEANCj4gwqAj
ZGVmaW5lIEJENzE4WFhfUkVHX09VVDMySwkweDJFDQo+IMKgLyogQkQ3MjcyMCAqLw0KPiDCoCNk
ZWZpbmUgQkQ3MjcyMF9SRUdfT1VUMzJLCTB4OWENCj4gKy8qIEJENzM4MDAgKi8NCj4gKyNkZWZp
bmUgQkQ3MzgwMF9SRUdfT1VUMzJLCTB4NTANCj4gKw0KPiDCoC8qDQo+IMKgICogQkQ3MTgzNywg
QkQ3MTg0NywgYW5kIEJENzE4MjggYWxsIHVzZSBiaXQgWzBdIHRvIGNsayBvdXRwdXQgY29udHJv
bA0KPiDCoCAqLw0KPiBAQCAtMTIzLDYgKzEyNiwxMCBAQCBzdGF0aWMgaW50IGJkNzE4MzdfY2xr
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+IMKgCQljLT5yZWcgPSBCRDcy
NzIwX1JFR19PVVQzMks7DQo+IMKgCQljLT5tYXNrID0gQ0xLX09VVF9FTl9NQVNLOw0KPiDCoAkJ
YnJlYWs7DQo+ICsJY2FzZSBST0hNX0NISVBfVFlQRV9CRDczODAwOg0KPiArCQljLT5yZWcgPSBC
RDczODAwX1JFR19PVVQzMks7DQo+ICsJCWMtPm1hc2sgPSBDTEtfT1VUX0VOX01BU0s7DQo+ICsJ
CWJyZWFrOw0KPiDCoAlkZWZhdWx0Og0KPiDCoAkJZGV2X2VycigmcGRldi0+ZGV2LCAiVW5rbm93
biBjbGsgY2hpcFxuIik7DQo+IMKgCQlyZXR1cm4gLUVJTlZBTDsNCj4gQEAgLTE1Miw2ICsxNTks
NyBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBsYXRmb3JtX2RldmljZV9pZCBiZDcxOHg3X2Nsa19p
ZFtdID0gew0KPiDCoAl7IC5uYW1lID0gImJkNzE4MjgtY2xrIiwgLmRyaXZlcl9kYXRhID0gUk9I
TV9DSElQX1RZUEVfQkQ3MTgyOCB9LA0KPiDCoAl7IC5uYW1lID0gImJkNzE4MTUtY2xrIiwgLmRy
aXZlcl9kYXRhID0gUk9ITV9DSElQX1RZUEVfQkQ3MTgxNSB9LA0KPiDCoAl7IC5uYW1lID0gImJk
NzI3MjAtY2xrIiwgLmRyaXZlcl9kYXRhID0gUk9ITV9DSElQX1RZUEVfQkQ3MjcyMCB9LA0KPiAr
CXsgLm5hbWUgPSAiYmQ3MzgwMC1jbGsiLCAuZHJpdmVyX2RhdGEgPSBST0hNX0NISVBfVFlQRV9C
RDczODAwIH0sDQo+IMKgCXsgfQ0KPiDCoH07DQo+IMKgTU9EVUxFX0RFVklDRV9UQUJMRShwbGF0
Zm9ybSwgYmQ3MTh4N19jbGtfaWQpOw0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVu
cyBBRw0Kd3d3LnNpZW1lbnMuY29tDQo=
