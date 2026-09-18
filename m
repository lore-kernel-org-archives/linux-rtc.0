Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013014.outbound.protection.outlook.com [40.107.159.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7093659FB;
	Fri, 18 Sep 2026 05:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789709254; cv=fail; b=GtA980OKcrxajTy/nx/fjB59ZG3nrSAWh20FxE57XFxGVuaKLGX1COkCKcbJTZaap3ERAuBn8vQ69PAgAcJMfMGXBn/CIEWoSn2doTRekv54ww53nVrwAcjVBGAWVBARkaI/s9QNPhy8CRWuDdvanL2XxzAD2qeuoFMcpqf96LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789709254; c=relaxed/simple;
	bh=6vkvmhjeXdBp1gWdN7pBE827s5OzewHUxRg4bF9op+o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KBpcZBUvlG44wRDtsnQQnmaOYnWPKMNNzZVkICiNSHcmIUe7AXK2bSOnLQ6bup15vE8RnnlJMNLMjXaIs+Qo6urk7OewiJZcaLIduMy1PD1SlzlFYV750IE2oL3FK+wRnZKkWhCHFY0CPEXYOr4Oz1PYDrhbQsbgjTxK9FjXlLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Yq5/cUKF; arc=fail smtp.client-ip=40.107.159.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Yq5/cUKF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbd4EDB++XGU5MFkOXtKQrlpsIVF/VIlbW4HyuAWdNzKu+84np8bnzdSKgfgYeCbAFoAlAh9tSQ/gPgC2bIMOnQgnIO2aJE03dbdVY/MaojYlI30qJu1Bxu60PzqXfe2mZu7Z9ZwWLRsSReG90onLHHxbr12HBtBkYWxyk97H6SsO89sHWvUoFtaf+pIyRDRpoB6fKY1TteL3WpfLknNGptZpmTQ+3nK/xG6u+r8nL9ttRWm2+/tUP7Jljl1cm2OprW0ncRNTA3uTYb5JFkqQUyyZxNjDdpABbfyAljm0JGkrfzefCQOSS8dH487SIZ80FfRn/2y6QsO2cK7F14Utw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vkvmhjeXdBp1gWdN7pBE827s5OzewHUxRg4bF9op+o=;
 b=R5iLHTTqx/KH+JDughbxSykmQpVAbkgjOKdmDW9TTG2K4P528H11ROP3g0J0oV3+Qi9l8Jn4OXv1Uxn5RdaEn4+UPt3vmg4odSJX09wonM03B6OTIrnm8T86H3au9b/0a+D9OP6yXkvdYiZZnzkmVEUd3JB2odAuUPhr9hGzuQHfYs3sMxtZuprPagNY3I6jKGfpygx6E3QlGLTpt05WYaTtZ80zuLi5V/RL8B5XE/Q/GfNjdYP+dbpVuBcW7yMDRCGsArMYaFGoObxCii9UNECurCD4P6g96haaL1y63tYJ81ln7RLg5yniVmNdT1IdwKrGjFYwAF+EuIBpbLSp0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vkvmhjeXdBp1gWdN7pBE827s5OzewHUxRg4bF9op+o=;
 b=Yq5/cUKF4noGImeH2BXd6AaE00nJ6ibO+UQbbajJe8RVDOpANGER0ob+D+WEr3JAm7RrlL6d2eSqrmeUdrA7cw4vMxf28LHaZuo/lSGISoZIwbS35MuTNcahb3Pt6JWQh1FqoC/+GImvpmVfIhqNz86McjgRh3LtHI0xULfD1nFfVcvX8FPQ/5A/xZ6rl2A2cVY8wn4RsgTIL+qrZwC2K+uOaXbqzsWHKVuL6EhMpf5PmA5KaiLFfADqzJzPUhc+ORep6Z2QPJTQdnIp5cTzNvPxe6T/Sc+qcbfYQCh4IYATE5mWfMK6KNiAku+WTRNXLYNvoFlyNtMxn3pzReXANw==
Received: from AS4PR04MB9362.eurprd04.prod.outlook.com (2603:10a6:20b:4e7::9)
 by MA6PR04MB716823.eurprd04.prod.outlook.com (2603:10a6:250:52::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 05:27:29 +0000
Received: from AS4PR04MB9362.eurprd04.prod.outlook.com
 ([fe80::abe7:4a6e:a51:baf0]) by AS4PR04MB9362.eurprd04.prod.outlook.com
 ([fe80::abe7:4a6e:a51:baf0%6]) with mapi id 15.21.0406.007; Fri, 18 Sep 2026
 05:27:29 +0000
From: Lakshay Piplani <lakshay.piplani@nxp.com>
To: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>,
	"sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "robh@kernel.org" <robh@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-rtc@vger.kernel.org"
	<linux-rtc@vger.kernel.org>, "alexandre.belloni@bootlin.com"
	<alexandre.belloni@bootlin.com>
Subject: RE: [EXT] Re: [PATCH v10 2/2] rtc: Add NXP PCF85053 driver support
Thread-Topic: [EXT] Re: [PATCH v10 2/2] rtc: Add NXP PCF85053 driver support
Thread-Index: AQHdRFOLfwNmYffoUUKaWaEiqlRUlrbOI7GAgAADF1CAAqlXgIADAolw
Date: Fri, 18 Sep 2026 05:27:28 +0000
Message-ID:
 <AS4PR04MB9362AEA2580F79CAF56C946EFB872@AS4PR04MB9362.eurprd04.prod.outlook.com>
References: <20260914141537.3881890-1-lakshay.piplani@nxp.com>
	 <20260914141537.3881890-2-lakshay.piplani@nxp.com>
	 <20260914143439.D15BA1F000FF@smtp.kernel.org>
	 <AS4PR04MB9362A2DD5743B2F472371A3BFBBB2@AS4PR04MB9362.eurprd04.prod.outlook.com>
 <7c65ba5ff099507dff8985fc140ac247396df63b.camel@siemens.com>
In-Reply-To: <7c65ba5ff099507dff8985fc140ac247396df63b.camel@siemens.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Enabled=True;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_SetDate=2026-09-18T05:22:10.0000000Z;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Name=NXP
 Confidential;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_ContentBits=3;MSIP_Label_0d9c909a-577b-4ba2-96de-69ada94b137a_Method=Standard
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9362:EE_|MA6PR04MB716823:EE_
x-ms-office365-filtering-correlation-id: 03a9e26e-a9c6-43f7-28c9-08df1545882d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|1800799024|23010399003|376014|366016|13003099007|38070700021|4133799003|10067099003|4143699003|11063799006|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 lwjbwDaFESTRr+XBjIiNTV05qdqODbTx5COGkpJ9bkllKWH5okRHDgtncZ1yRYEjqVVWx0L4bZXRa7UHWwbs/VDoM+0LY8F2K33Upw3ULfHiNbTJ3wHGIy3QZYM0BKayqMUsnwXBtRB14Yak9fvHT5IL5OWIDYYUEEHNM3MsyN74bG5wlR+15FRkTfjnjbJPm5sZxjpsEc5umsPyg4s5c6oWk9pZcgPe023vsL6owboivTXfcqxifKxDchYskAjmxWV/OYHvam56086/T7cUDH/ALXxGqekWfUWudneNl2/1W+ds+/GqfyLwnS0a5CcecpoEyjRjSPMSijQ7VAwEGwTmzqi50HRwvKf4o8q6hh6t0BBJx/1bsnOFiug/2eptag286vndRs7tS8l70TuoKwQPaHztXicRCaoW87w6eRNorqDH/IUF5FTPnnmL3+YGe/Hr4a/0PQRtjghukrgFsjdRvQhGyxUFJM+5ZhN6KtP4hmnOnhCJYvNfoWqr+p3/HA91zf6Pz+RKV6Lik0fwMW1LR6ObhowlEZk2vE37BeFzQucFI/dndJC+yX/ffwF9W/s/jc3FWGCaIpUEyJb0jp5v0o6gyn7odHpiuSHjsd1Lv3X/tJQ/1o9ZkEBYtEjMsO4hrw9IjRejSJ3Po+f5klDJifs3VVLiwndNIKLdpqY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9362.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(23010399003)(376014)(366016)(13003099007)(38070700021)(4133799003)(10067099003)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VEVxQ1RnRmpaOCtYLzRkcjRwN09vSlY5QWdtUzFuSDZnaHFqSFBOanZ1L3dS?=
 =?utf-8?B?RkhuM2R0ZTZsZ0VSb1dFd20yU1RLZnFFS0hDa3FJVVlpQm02ZVFLa3laUWlE?=
 =?utf-8?B?U29SMDdOUjhBOWhwenBSaWZTMFZiYUxrYlNpUVd3TG1uMTJGTmhvNUQ5V1Rh?=
 =?utf-8?B?bWdTejNwRVA3aS9JWncxZUdoRncwa0VUa1N1K1ROckhZaEZqMnd3OW9ZMmdG?=
 =?utf-8?B?eGluTTVsT2JZWE56TkI0NTM5OVd6UTAva3g1cWZCUmVRMnQzUHdtbi9vUGU2?=
 =?utf-8?B?QmtDcWg5WURkWTlWYm1hZStxRjBvMnBIVTdhV3hoUmErVHExQ3JEK2hBZWJq?=
 =?utf-8?B?WVo4MURtaEFPcEtsKzNTVFBjM29JQTZrcDkxSlRjS0NsOEpEWmdTVExyQ1p1?=
 =?utf-8?B?T3p4RGtqL2ZFZW5KVG5nclpsa3ZEbGFxejNsdTArY1RaK25KSXMwZnltRnBk?=
 =?utf-8?B?emhxWElpT0FRZmpuUTZTYWtPZGlvb25zMVQ1dU9xdnF1M1VjdkFjZ3lwdXRv?=
 =?utf-8?B?UjA0OVE3RGliZ25xTVo3TEhNL1pheEt1cE12NDA2d2ZnSHd0alJQU1NVdDFr?=
 =?utf-8?B?NE8ySGhSR0ZUZDdheHVJcEJGMjU3THBncWtLZ2pDWWo1aXM3Um40blV5ZC9s?=
 =?utf-8?B?UW95TE1jZTdsNHJwb1RQZ2FEM0dJVTRURXh5eDZyQ0NxU2dYN1dWRnJXWWo0?=
 =?utf-8?B?TzVtNytFZjN5M0pXTUFadjhQTTJGaDdRMjUwaTR5amRDU0UreUJEWGpzV1pz?=
 =?utf-8?B?cHRZUVFIV09pS3A0TmNSU3pQVjNHV2Y4OFJ2Z1IyUnZWODFySmk0SjdnWHZz?=
 =?utf-8?B?dDMwQkk4a2NwdlMzMUliSUU0SUh5dHprRUZld1dzK25IdlhNejRCVGNINHBU?=
 =?utf-8?B?cS83RC9aL2JodXBtUVJIVk8vcDVKbld1RFhHdklvZHJIZ1A5M3lCNUFOQUhZ?=
 =?utf-8?B?ZTQrbnVrSGpWVGEyVkh2bE8vclBxUzBITDZZd01KMUQyaFBRcmNKcHJNTDQy?=
 =?utf-8?B?dUs5YjhianNUYVR3bEsxbUFMc3MvM3pEUFNrOHZtS1BPRklNcW5kV2RLK1da?=
 =?utf-8?B?V1hrSnJnZEE4NWFueEptYTFBeTVCcDYzUy84ZmxxUWdtOENNMlhwTVZPZ3kx?=
 =?utf-8?B?VHFrYTVNRGRiOUl0eVpzb004RmlnODFtdlJaL3hSbmZSZkRSS2RjQUxKN00x?=
 =?utf-8?B?S2hMRzNDMkFXM25NOFV1Y3BvQXMzNnNuRThsRUtSbXB2ZmFFc2dRNmNRNjNU?=
 =?utf-8?B?aE1HeFZMWEFBTEhYOTl4eFYrRzFYRkNQRkV4OXA5bDkvd3c3US95QUZMdUFJ?=
 =?utf-8?B?ZUtlWDVRcWp1S09Ga3luTkMzRmRQZXFBQmNLSW4vNDJ2Q3RTN0NnNzNLRVhQ?=
 =?utf-8?B?WWMyQ1FROWhQNjdWaW91T2l2RTA0c2t3RUpUTzNGNWJ2R0dhWVFQbjl2eWpu?=
 =?utf-8?B?MXdwQWMwRStpNUhoM1FCOExmMi9IQ1hRaVBCWFplZkZsTlY1by9mdmZqSW1Q?=
 =?utf-8?B?MUxjZ0lPQ2dJNmNDeFBvZk5jWlUzT3VKakdBTzZLL2cwUCtQdW9SNWJGbGVU?=
 =?utf-8?B?alkzMUNuWitoc1lzZXh2Sm1ub05UY3doU29zR0lPSkhkckZ3SDZCVi9yQy9r?=
 =?utf-8?B?aWlCNzBwWkFGTGtKUnhTb1poaDJ0ajQzUC9SL052Z1V4RTVEcC9yWVNYeFM0?=
 =?utf-8?B?bmh4VVZsaHR1N3hrVFZlWFFDTjE2NFlQczFlOUdHM3NUanZ1SVhCc3B3REdT?=
 =?utf-8?B?Zk45OW1ReFp1YjZpUWZUTnEycndUT2N0ak45OVZaOWo2OEFoWit3eUxhdnpG?=
 =?utf-8?B?aDdydGxPZDFXQUEyT1ZNaHUvSlVMRjhsajBBcld3enN2OWtTQURXUTZIcVVy?=
 =?utf-8?B?K1M4Mm9ZN25MZERMaEZ5K2l2bWhiZWdFdFZqUWxhbHBJM1d6YjFpejZHTGh6?=
 =?utf-8?B?cUR3eUVRK0FCQTAwM0orbkkrTnBGWWg0OE9CK2xWOHB6ZStpV0xLWlhHQUh1?=
 =?utf-8?B?c3l0QnJHYU85MnVDVjZaamxxNFVLZUJDUnZzbkFLdGhjYUJjYmNQcmk3TUxS?=
 =?utf-8?B?NVJYMG5RZGtBSlVDcEdiLzZkUmh3d2pQaktreGp5NjcrOXJVam5oMlRqWmU5?=
 =?utf-8?B?K3grU1RnY3psK3BrZzdpUUF2WWZnRDhBVjVZY0lHK05uOWZyakJhUUY2VDZH?=
 =?utf-8?B?Z0RnNzQ1Z0xQY3Q3ZnFTWUI1UDZZVW5kaUhuWFdRWmtrQTZDWnpPbGRXSktG?=
 =?utf-8?B?ZGdudlladkhKK0RDejVKeVJYeUpBRDFZcGFXQXJQendRblNsd2xyZjZ2ak1m?=
 =?utf-8?B?ejYrTktXVEo3RWUyT2duVnpSdGZudko4bE5tVThUY3VnaVRPWXpTZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9362.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a9e26e-a9c6-43f7-28c9-08df1545882d
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2026 05:27:29.0209
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QLZaMZDTauOevc5fphVKQ490FUnFfcVvuPQgSdRcfxhjXrCumd5fHZEgglQoEhM4iToLzirQi8fAZzcusyh6FQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA6PR04MB716823

SGkgQWxleGFuZGVyLA0KDQpQbGVhc2UgZmluZCBteSBjb21tZW50cyBpbmxpbmUgYmVsb3cuDQoN
Cg0KTlhQIENvbmZpZGVudGlhbA0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBTdmVyZGxpbiwgQWxleGFuZGVyIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQo+
IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVtYmVyIDE2LCAyMDI2IDEyOjU0IFBNDQo+IFRvOiBzYXNo
aWtvLXJldmlld3NAbGlzdHMubGludXguZGV2OyBMYWtzaGF5IFBpcGxhbmkNCj4gPGxha3NoYXku
cGlwbGFuaUBueHAuY29tPjsgYWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb20NCj4gQ2M6IHJv
YmhAa2VybmVsLm9yZzsgY29ub3IrZHRAa2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5l
bC5vcmc7IGxpbnV4LQ0KPiBydGNAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbRVhU
XSBSZTogW1BBVENIIHYxMCAyLzJdIHJ0YzogQWRkIE5YUCBQQ0Y4NTA1MyBkcml2ZXIgc3VwcG9y
dA0KPg0KPiBbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGFsZXhhbmRlci5zdmVyZGxp
bkBzaWVtZW5zLmNvbS4gTGVhcm4gd2h5DQo+IHRoaXMgaXMgaW1wb3J0YW50IGF0IGh0dHBzOi8v
YWthLm1zL0xlYXJuQWJvdXRTZW5kZXJJZGVudGlmaWNhdGlvbiBdDQo+DQo+IENhdXRpb246IFRo
aXMgaXMgYW4gZXh0ZXJuYWwgZW1haWwuIFBsZWFzZSB0YWtlIGNhcmUgd2hlbiBjbGlja2luZyBs
aW5rcyBvcg0KPiBvcGVuaW5nIGF0dGFjaG1lbnRzLiBXaGVuIGluIGRvdWJ0LCByZXBvcnQgdGhl
IG1lc3NhZ2UgdXNpbmcgdGhlICdSZXBvcnQNCj4gdGhpcyBlbWFpbCcgYnV0dG9uDQo+DQo+DQo+
IEhpIExha3NoYXksDQo+DQo+IE9uIE1vbiwgMjAyNi0wOS0xNCBhdCAxNDo1MSArMDAwMCwgTGFr
c2hheSBQaXBsYW5pIHdyb3RlOg0KPiA+IEhpIEFsZXhhbmRyZSwNCj4gPg0KPiA+IEkgd2FudGVk
IHRvIGdldCB5b3VyIHZpZXcgb24gdGhlIHR3byBuZXcgU2FzaGlrbyBmaW5kaW5ncyByZXBvcnRl
ZCBvbiB0aGUNCj4gUENGODUwNTMgdjEwIGRyaXZlciBwYXRjaC4NCj4gPg0KPiA+IFRoZXJlIHdl
cmUgbm8gZHJpdmVyIGNvZGUgY2hhbmdlcyBiZXR3ZWVuIHY5IGFuZCB2MTAsIGFuZCB0aGUgZXhh
Y3Qgc2FtZQ0KPiBpbXBsZW1lbnRhdGlvbiB3YXMgcmV2aWV3ZWQgY2xlYW5seSBpbiB2OS4gSSBh
bHNvIHdlbnQgdGhyb3VnaCBib3RoIG5ldw0KPiBmaW5kaW5ncyBhZ2Fpbi4NCj4gPg0KPiA+IEZv
ciB0aGUgZGV2cmVzL1VBRiBjb25jZXJuLCBteSB1bmRlcnN0YW5kaW5nIGlzIHRoYXQgdGhlIFJU
QyBvYmplY3QgaXMgc3RpbGwNCj4gYWxpdmUgd2hpbGUgdGhlIG1hbmFnZWQgSVJRIGlzIGJlaW5n
IHJlbGVhc2VkLCBhbmQgUlRDIGNvcmUgc3luY2hyb25pemVzDQo+IHBlbmRpbmcgaXJxd29yayBi
ZWZvcmUgdGhlIHJ0Y19kZXZpY2UgaXMgZmluYWxseSBmcmVlZCwgc28gSSBkb24ndCBzZWUgYW4g
YWN0dWFsDQo+IHVzZS1hZnRlci1mcmVlIHRoZXJlLg0KPiA+DQo+ID4gRm9yIHRoZSBhbGFybSBJ
UlEgcmFjZSwgSSB1bmRlcnN0YW5kIHRoZSBpbnRlcmxlYXZpbmcgU2FzaGlrbyBpcyBzdWdnZXN0
aW5nLA0KPiBidXQgSSBhbSBub3Qgc3VyZSB3aGV0aGVyIGFkZGl0aW9uYWwgbG9ja2luZyBpcyBh
Y3R1YWxseSByZXF1aXJlZCBieSB0aGUgUlRDDQo+IGNvcmUgb3Igd2hldGhlciB0aGUgZXhpc3Rp
bmcgaW1wbGVtZW50YXRpb24gaXMgYWNjZXB0YWJsZS4NCj4NCj4gSSd2ZSBnb3Qgc2ltaWxhciBT
YXNoaWtvIHByZS1leGlzdGluZyBmaW5kaW5ncyBmb3IgUENGODUwNjM6DQo+DQo+IGh0dHBzOi8v
bG9yZS5rZXIvDQo+IG5lbC5vcmclMkZhbGwlMkYyMDI2MDgwNzEzMTUwNC41QzZBNDFGMDAwRTkl
NDBzbXRwLmtlcm5lbC5vcmclMkYmZA0KPiBhdGE9MDUlN0MwMiU3Q2xha3NoYXkucGlwbGFuaSU0
MG54cC5jb20lN0MyM2M4NWMzYTU4NjI0OWQwNDA0MzA4ZA0KPiBmMTNjMzg3MTklN0M2ODZlYTFk
M2JjMmI0YzZmYTkyY2Q5OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM5MjUxNA0KPiAwMjY3NDg3MTc2
OSU3Q1Vua25vd24lN0NUV0ZwYkdac2IzZDhleUpGYlhCMGVVMWhjR2tpT25SeWRXVXMNCj4gSWxZ
aU9pSXdMakF1TURBd01DSXNJbEFpT2lKWGFXNHpNaUlzSWtGT0lqb2lUV0ZwYkNJc0lsZFVJam95
ZlElM0QlM0QNCj4gJTdDMCU3QyU3QyU3QyZzZGF0YT1MeXR3Y0NrRjQ4SkhwSU9VT21hMVolMkJo
akprd0pCJTJCUFJQbm52DQo+IENKVHNMT1ElM0QmcmVzZXJ2ZWQ9MA0KPiBodHRwczovL2xvcmUu
a2VyLw0KPiBuZWwub3JnJTJGYWxsJTJGMjAyNjA4MjAxMTM5MDYuOUJEOTkxRjAwQTNBJTQwc210
cC5rZXJuZWwub3JnJTJGJmQNCj4gYXRhPTA1JTdDMDIlN0NsYWtzaGF5LnBpcGxhbmklNDBueHAu
Y29tJTdDMjNjODVjM2E1ODYyNDlkMDQwNDMwOGQNCj4gZjEzYzM4NzE5JTdDNjg2ZWExZDNiYzJi
NGM2ZmE5MmNkOTljNWMzMDE2MzUlN0MwJTdDMCU3QzYzOTI1MTQNCj4gMDI2NzQ5Mjc2MzIlN0NV
bmtub3duJTdDVFdGcGJHWnNiM2Q4ZXlKRmJYQjBlVTFoY0draU9uUnlkV1VzDQo+IElsWWlPaUl3
TGpBdU1EQXdNQ0lzSWxBaU9pSlhhVzR6TWlJc0lrRk9Jam9pVFdGcGJDSXNJbGRVSWpveWZRJTNE
JTNEDQo+ICU3QzAlN0MlN0MlN0Mmc2RhdGE9NUhTRHRRQU1JSUhoUU1tYlhTTGt5b3dXRGY4bjVh
T0xZd0pYNkUNCj4gQWUlMkY1byUzRCZyZXNlcnZlZD0wDQo+DQo+IGFuZCBlbmRlZCB1cCBkcm9w
cGluZyB0aGUgQUlFIG1hbmlwdWxhdGlvbiBpbiB0aGUgaGFuZGxlcjoNCj4NCg0KTWFrZXMgc2Vu
c2UsIGJ1dCBkb2VzIHRoaXMgYWRkcmVzcyB0aGUgaXNzdWUgcmVwb3J0ZWQgYnkgc2FzaGlrbz8N
Cg0KPiBodHRwczovL3BhdGNody8NCj4gb3JrLmtlcm5lbC5vcmclMkZwcm9qZWN0JTJGbGludXgt
DQo+IHJ0YyUyRnBhdGNoJTJGMjAyNjA4MjgxNjQ0NDUuMzkwNzgzOS0zLQ0KPiBhbGV4YW5kZXIu
c3ZlcmRsaW4lNDBzaWVtZW5zLmNvbSUyRiZkYXRhPTA1JTdDMDIlN0NsYWtzaGF5LnBpcGxhbmkl
NA0KPiAwbnhwLmNvbSU3QzIzYzg1YzNhNTg2MjQ5ZDA0MDQzMDhkZjEzYzM4NzE5JTdDNjg2ZWEx
ZDNiYzJiNGM2ZmENCj4gOTJjZDk5YzVjMzAxNjM1JTdDMCU3QzAlN0M2MzkyNTE0MDI2NzQ5NzUw
NjglN0NVbmtub3duJTdDVFcNCj4gRnBiR1pzYjNkOGV5SkZiWEIwZVUxaGNHa2lPblJ5ZFdVc0ls
WWlPaUl3TGpBdU1EQXdNQ0lzSWxBaU9pSlhhVw0KPiA0ek1pSXNJa0ZPSWpvaVRXRnBiQ0lzSWxk
VUlqb3lmUSUzRCUzRCU3QzAlN0MlN0MlN0Mmc2RhdGE9NDBSUDBmcQ0KPiB4YkJDRXJ1SUNtJTJC
RktMR2dJUDVQbnFwM3NIaGdIdHZ5UkxVMCUzRCZyZXNlcnZlZD0wDQo+DQo+IERvZXMgaXQgbWFr
ZSBzZW5zZSBmcm9tIHlvdXIgUG9WPw0KPg0KDQpGb3IgdGhlIGRldnJlcy9VQUYgZmluZGluZywg
UlRDIGNvcmUgY2FuY2VscyAiaXJxd29yayIgYmVmb3JlIGZyZWVpbmcgdGhlICJydGNfZGV2aWNl
Iiwgc28gSSBkb27igJl0IHRoaW5rIGFueSBhZGRpdGlvbmFsIHRlYXJkb3duIGNoYW5nZSBpcyBu
ZWVkZWQuDQoNClRoYW5rcyBmb3IgdGhlIHJlZmVyZW5jZS4NCg0KQmVzdCByZWdhcmRzDQpMYWtz
aGF5DQo=
