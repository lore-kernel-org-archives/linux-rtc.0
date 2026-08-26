Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010047.outbound.protection.outlook.com [52.101.84.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45E6392C46;
	Wed, 26 Aug 2026 06:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787724793; cv=fail; b=fA2UIfSST2S1JzL/lVf3BKyvsnRRVR35bke4mu09FqcCxxm4t1XcQs2CsX8jXvRJtAsaVw7ewVeRI5eTqx6onFDZwNxtA7U8RgBiASopZqN5DHlr89Dk07FvHBoNzE3Y6uwo3IvjKD2rn/MH1/TcvTYfTCHtDH1+tziLvwDEUj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787724793; c=relaxed/simple;
	bh=oYtMHlFPsCtileByin6DBmPnyh96b0JuexJTVo/7SNo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IAioxJtIFn3d8F9fIYnX08kLWj55MBOG8zjoRNp8fd4i2Is6uQJ75v8BwUro7Z+KayjKJkxpK9dJDLL/NcXm0tnMbnQcdaxIwFxvhiySclIbW7l7u0WWFPrUyPm6p8LQxVb7MyfkrXeRYqwl2gSTqYUVke+tn/ZtotUPt3eCguI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=xuQUMuLD; arc=fail smtp.client-ip=52.101.84.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="xuQUMuLD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lH0mZvVofjLNI+RwLAojEfM34mLSW2YRxENeJFmR05IzUSOWc7EHZ4n0aw3AvILq77g24Cj6vXvjDSKqETKunF1MHDLaDRZq+5Wuu8ZdR3OYwcLUVYDupWmFt/hASGwIcAwsDmNAGG7/xAZGuQI/ext/iN6i2k2wcP80vuVLyw4JoqxBwTTnZ2eoCHfQNdIJrQoJQurBX5fCcpc+pz4piBJMtOyCy6tE8k8ZY774ELVQLjvPo8AZdECXKP99X+iYFBoIolrOazGnvw+2bP6IWtanV9XM1Th/0gwVQxBA3YhlvX7tHo0+jXy0dL4jDGphNnwvjBppRQGRsHS0t58Kvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYtMHlFPsCtileByin6DBmPnyh96b0JuexJTVo/7SNo=;
 b=kdsCbrgpU1lXd+bsaE0pL5/pfjOWzR5DzF+Sey5MUi3H2LMGSq3mMKOfJw2ocywFS68egWw3Hs2um37C9DPysTjRXInqcEuvhdFu1ASAalmuU8zD6GbebiMiQjrQLhzvXyAUZcRbp3ptfB+SCUP/IkAGstly3Y/4dahd8gl1UEGa98C7ilkA86JnodVF6UmbxMyL765l0K0CmJE7iFHwpD0ZFind3tHY6xNWO/+kQ9LmCUS9QhEfbUL8KxTv2EvWeAZzkHj/a3NkqP+pJAIO0KTrOVzxiK2ZEUdIqFInrXj4Hgl1BsjJlQUwenGUNzIgIxbPrQKCriwLb7kNksO7EQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYtMHlFPsCtileByin6DBmPnyh96b0JuexJTVo/7SNo=;
 b=xuQUMuLDzpJcHa5PGVofTLIedEcDMi9oQZs1OacLPwA/n5eyPDbCY0vIVj46hb1G6nV7O7QeomTWhdHynYcYaAIC/zSN25il8b7+zCjQjuvMyqccFo2QyOCrBZwyAxMCZ17wITht49KMbp7hdW6L1RMx0jIS7SbbIurwv9eGKqmMvZK+zAbmdk2UMiJpYZ1ReEHOQgGmezitAt2yirG3SyFIBuSfxU4FCto9aiJPShkRM4KZluGqZQU+x0HJXy3VDU+AjNe+myEkW5l4CXBXfi3OVUwQYpjDyJh68niDI2kt00Z8VG+m+GUhahvAULC1zCT/6rAoE+5kgLZbHiMqdw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AS8PR10MB6769.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5bd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Wed, 26 Aug
 2026 06:13:08 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.21.0339.012; Wed, 26 Aug 2026
 06:13:08 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC: "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtc: pcf85063: disable the clkout output by default
Thread-Topic: [PATCH] rtc: pcf85063: disable the clkout output by default
Thread-Index: AQHdM5+zm/6L93bGqUCe6AyZPAteyras3NcAgAAaEoCAAk1VgIAAmG0A
Date: Wed, 26 Aug 2026 06:13:08 +0000
Message-ID: <f4ae12f3fba06fc00c74f76555d684c1fa706179.camel@siemens.com>
References: <20260824080801.709764-1-alexander.sverdlin@siemens.com>
	 <20260824082456e0edd7c6@mail.local>
	 <2ce03d3b4cd9cce8e32fe1fe1ffbea5760bf9ef3.camel@siemens.com>
	 <202608252107336920b1e4@mail.local>
In-Reply-To: <202608252107336920b1e4@mail.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AS8PR10MB6769:EE_
x-ms-office365-filtering-correlation-id: f9ed9cb5-2e57-46ab-2978-08df03391949
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|10070799003|376014|23010399003|366016|38070700021|11063799006|10067099003|4143699003|56012099006|5023799004|22082099003|18002099003|55112099003|3023799007;
x-microsoft-antispam-message-info:
 2O2A4N071b2c4cgSbPXTkR3YZPJSDT85MtXpOdNU+GW53OIOsYv2G8U29opIaLq/xMf+9w9OrH1JGGrXoFDlmgJOeYRsF4e+ym4gB4PoY/SkK6ptUupyHzEsW/kPTTHC5SVq2G0RW8yBGY+kJoP01sRZEdyWD3ZMMTYu4MRfH2NhloPDcsjLLVWLnnSy9d70jfZVVEbBgFq1ZmBNxFV26Nz4LgLuw009ub++4fsNyTMo5Ly6JPoKt8i8uDU5DjtKrANYW9OClQzkV4G9CKxh719qPy3eZYySJK6a6V87OtnDtd0mAY0/wRIDTKTBXdV3Icveqn5MuMZ/Ipylh2I88x50W8/INvU40sB4wqE80qM9oRhkhWTKGTrwi959QFartA7IYMDex8FYdtBsvtIJCz/mqgzFTWmAeG7ocw+lGfm4mA+ZLO6wLH42gZOdCHIyBQDh0Kcdg5c+0tb03xjyniDVlZgKi6A79uztASDAakAw4jiR5Yqpm936zVT653n4UeOYrlAJg33ajkAK9jxtdUykDUyvoPOW4O4LGcTXSbmNCF0OYbmRULTn+uBrNEPlg9jjr9Go8jLZfbfpMOCpE5dcfn2ozN3d32qCAzb4LUzCWKX5oreuTaYIEOo49zxiUvwNKQTBemWy/6c/Wvyk6Nl/KCbqNO8cIU9CInTiLyY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(376014)(23010399003)(366016)(38070700021)(11063799006)(10067099003)(4143699003)(56012099006)(5023799004)(22082099003)(18002099003)(55112099003)(3023799007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SFNsSHNKeDVRU1FIZXFZUWlmYk9PY01WYXFRMjZ5Wnhnc200bktFSzFJenY0?=
 =?utf-8?B?c3Zodjgyd1pJZXUrUnZWY3p5Y0dnUWU1cjlUdElXNkdvZDU0YWFaSDZkNU90?=
 =?utf-8?B?akFrVlFLVkRncDBKKzdpK3FZaXRIWUdMazA2SnpqZkZkN25rcEUyNThCaTVo?=
 =?utf-8?B?RWtwb0wvQ0Qwcm5acllqVEd1YWsyaVJIL01tQnRGRzEyTmFxR1BhQlJwVTdo?=
 =?utf-8?B?UzhsZmR1UCtYYmlHVjBIVmxML0FxZUtBTWtJRzFXM0E0YnE2azRrYzdUSjZU?=
 =?utf-8?B?ZlJRNm0xaHliRng0dEE2WWk5VUVGa2N2d1JvdDA5cVAwTGoxR0ZXL2xJV2s2?=
 =?utf-8?B?MFZtalRoSS81V05RODJQaGphRjJQL05PSkcwWW5LanVWTVVhbXVEYVhESS9t?=
 =?utf-8?B?WlBJbVlvUmxnVCsyMU9YMFdMVUpiUVpoK1hiK1ppakNLSWcvYVhZSjNaNWJr?=
 =?utf-8?B?ZEZTeFZPRHc4WGxVRGd2Y3FMakJic043ZmRKMUlvcmtqTmxFdGdDemZEbGxY?=
 =?utf-8?B?cXZRSHBSVXVjNEhmQ3YrVzNNSEhWUlg4bXNZR0dFb2ZDbWJLNkZaR1VoUEV5?=
 =?utf-8?B?L1hPekVyMVMybW5HR29BK3dWQTFUSTJPRnlYTTFnZ3VSTzY1em1YWCttc2J3?=
 =?utf-8?B?c29MRHEzcDNZb0prNHB3bS9Pc293Rk9mN2lwSDNVVk5HVEFZN0ZRUFBrZGI2?=
 =?utf-8?B?VzJUNGRkdmFqa2NmaHZmOFJwNlp1RjdrdGZtK0dWTlV1amdoaUxFYjY3NnRQ?=
 =?utf-8?B?TW93L25VcnlacTl1ZWFWSUYyc3dzRldXd2dBQ0x4ZGJWNzYzaVpkYVYzTm5y?=
 =?utf-8?B?VUorZ2l3dmppNWdGclBDbU42ZW5ScjZCbnk1a1VldmxVWmhheWZyR00rSlRG?=
 =?utf-8?B?bW50K0RRZG9VZGFwSS9HTlB2NG9MVlFmbzE0RnU1clREZFhBRThCUE5yaW5p?=
 =?utf-8?B?VjdrQUx2L3g4bzhreGFiYmVkWkFUdENhbWpkMFRrZVhyQmNENWZIbE8vS0tD?=
 =?utf-8?B?TmZIc1E4N0pjaDZhZmtpNy9xQ1luSCtVckVNVDhLNkl0YmoxblMxTDJNR2NH?=
 =?utf-8?B?NG1pYkRhZnlJVXo3NWhBVzBjYkl4MTFwWVAxM01wV1NEbnBKK0xnU2NsN2xJ?=
 =?utf-8?B?cTZDN3NKdER1aG9RNExHYjlKam5oZ0NHTmlJTS9NbjlzZjZ4dlF6UTF2VHNt?=
 =?utf-8?B?Z2hxS1NTSitCNG5rVkVVMU5rQ3pUT1NPYkhCdXhwV0NPN3dYTVYzdzlxVUNl?=
 =?utf-8?B?bksvVGg1bmowR0dsOHhjY1JFUzVpTXZaVVNtZ1paczBMR0NBYm01c212OTFz?=
 =?utf-8?B?M2tpenpNRkV2ZDkvbWN5dGs5S2JxbHdZRndYclFLTEJQb05XQjBUUFVNZFZC?=
 =?utf-8?B?NXVaS0xFOEw5ZVlQYUxidWNNdHQvTUlhRFg4SndWTTNxZXJNZUZGQnhOeFVo?=
 =?utf-8?B?WnRmOS9FeklKNllxRG5jdHQyb2RqSnJzMDJOdExaNkNCV0t1b01vTGE1Mmln?=
 =?utf-8?B?STYzRXpZUnFaeS9MNXZ3RmF6Q1VDbmZUUmFOZ3cyamlwZmZ5TFZOeVVuR0hL?=
 =?utf-8?B?NzgyRUV5Wk1DVVdlb1libE5ESURkMW1BZnN0cTRIc2Q4U056VWV6OWF5OUFj?=
 =?utf-8?B?SnJGSUFFVFlxQ1R2cVVHS0h5RU9RNndESERsbUdiOSs2RlJZOXEyT2MxUGt5?=
 =?utf-8?B?MEUvRWx4R0hZZlJIMDBIbHlRTnNuOS9YcTdTYWlWWGtneTZuQ3E4UXptek43?=
 =?utf-8?B?SmJiS2xEQUdUUFh2OVFlN2g1MjY3dVk2WWo2VGdwdkc4NmNsUTBSMDA4N0xD?=
 =?utf-8?B?RnpBL0NxSUtXbzRscEEvaVc4MHQvOUFuWi9SOFZiZS9GWUFLbS9DYWxkSUZS?=
 =?utf-8?B?NnlqNnFOWTFUVWVmYS9zYzZ3NG83TWZ6cGVRN3BTbnhkSnE0bmI1YXVZYTNL?=
 =?utf-8?B?K0szMHorVEVMNlpIOVdRWHJ6cW5QdTNDNjdTSmY3bndyTHZsQWp2WVFKZkZM?=
 =?utf-8?B?WWluanNNTEVoTklxN0RIbElsV0NuYWtBY2kwQmh5MGo5b2pWbFUrd0NLbzNz?=
 =?utf-8?B?ZDhvQzRjQWhZL0hKR1VQcnJwQTRUMVVvQWZ0cGh5d0Q3Y0tpa203NENRdmN3?=
 =?utf-8?B?V2xHU2prY050WjFqTWZwaXR1bUhVcXFtcVRwanFnK2hVSXAwK1FVOEN6MGV1?=
 =?utf-8?B?ZStGRXc1YlFkQm4xR2RQRXYwY0o0M2hYR3RGQXdveURVa3ZhNDVZczNMT0dL?=
 =?utf-8?B?V2dla3B4bXlVZ0c1ZDdrdURWOE9pMXVMQk1BRThEeFhCbE5ZcjRoc21JUkpL?=
 =?utf-8?B?czJrbVQ3bGkwSmk5WXU0ZU9HMlNBd3FjZm9pSnVDMUFveHZsanpQVnBlN3lo?=
 =?utf-8?Q?r40sMPwXLq/a/pAqiwJI3ywk5GrT8sqzXirKMuf/0T6dt?=
x-ms-exchange-antispam-messagedata-1:
 Jsc2IXqjJfI7B2e744CcF6bJ+JTwZ7ltIc+M8t6pIHtuTJI9XsIEPkB/
Content-Type: text/plain; charset="utf-8"
Content-ID: <83FF3CA08790134E84F24D338E3A4718@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f9ed9cb5-2e57-46ab-2978-08df03391949
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 06:13:08.1647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TNG2TdAWlgthFHUiUy67SODBjGP9q7oXTJaKjTWG4pw0/saTAUa7IbPa/ZxdeXqRrosUdSRqDcymKtULyGI69Jf/8mlzMXCpN3Q1etGsvpU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB6769

SGkgQWxleGFuZHJlLA0KDQpPbiBUdWUsIDIwMjYtMDgtMjUgYXQgMjM6MDcgKzAyMDAsIEFsZXhh
bmRyZSBCZWxsb25pIHdyb3RlOg0KPiA+ID4gPiBUaGUgUENGODUwNjMgcG93ZXJzIHVwIHdpdGgg
aXRzIENMS09VVCBwaW4gZHJpdmluZyB0aGUgMzIuNzY4IGtIei4gV2hpbGUNCj4gPiA+ID4gaXQn
cyBwb3NzaWJsZSB0byByZXF1ZXN0IGEgc3BlY2lmaWMgZGVmYXVsdCBmcmVxdWVuY3kgaW4gdGhl
IERUIHZpYQ0KPiA+ID4gPiBhc3NpZ25lZC1jbG9ja3MvYXNzaWduZWQtY2xvY2stcmF0ZXMgb24g
dGhlIFJUQyBub2RlIGl0c2VsZiwgZXZlbiB3aXRob3V0DQo+ID4gPiA+IGEgcmVhbCBjb25zdW1l
ciByZWZlcmVuY2luZyB0aGUgY2xvY2ssIHRoZXJlIGlzIG5vIHN1Y2ggcG9zc2liaWxpdHkgdG8N
Cj4gPiA+ID4gZGlzYWJsZSB0aGUgY2xvY2sgb3V0cHV0IGJ5IGRlZmF1bHQuDQo+ID4gPiANCj4g
PiA+IEFyZSB5b3Ugc3VyZSBhYm91dCB0aGlzPyBUaGUgQ0NGIHNob3VsZCBkaXNhYmxlIHRoZSBj
bG9jayBpZiBpdCBpcyBub3QNCj4gPiA+IHVzZWQuDQo+ID4gDQo+ID4gVGhlcmUgaXMgbGF0ZV9p
bml0Y2FsbF9zeW5jKGNsa19kaXNhYmxlX3VudXNlZCkgKG1hcmtlZCBfX2luaXQpLCBidXQgZm9y
IHRoZQ0KPiA+IGNsb2NrIHByb3ZpZGVycyByZWdpc3RlcmVkIGxhdGVyLCBzYXksIHZpYSBtb2R1
bGVzLCB0aGVyZSBpcyBubyBzdWNoIG1lY2hhbmlzbS4NCj4gPiBBbmQgSSBkb3VibGUtY2hlY2tl
ZCB0aGlzIHB1dHRpbmcgc29tZSBkZWJ1ZyBwcmludHMgaW50byB0aGUgZHJpdmVyLA0KPiA+IG5v
dGhpbmcgZnJvbSBzdHJ1Y3QgY2xrX29wcyBpcyBiZWluZyBjYWxsZWQgd2l0aG91dCBhIGNvbnN1
bWVyIGluIERULg0KPiA+IA0KPiANCj4gUmlnaHQsIHNvIHdoYXQgYWJvdXQgdGhlIHBhdGNoIGF0
dGFjaGVkIHdoaWNoIHNlZW1zIHRvIHdvcmsgZmluZSB3aXRoIG15DQo+IHJ2MzAzMi4NCg0KVGhl
IHBhdGNoIHdvdWxkIHdvcmsgZm9yIG1lIGFzIHdlbGwsIHdpbGwgeW91IHB1Ymxpc2ggaXQgb2Zm
aWNpYWxseT8NCg0KQlRXLCBpdCdzIHJhY3ksIGlmIF9fY2xrX3JlZ2lzdGVyKCkgd291bGQgYmUg
Y2FsbGVkIGJldHdlZW4NCg0KCWNsa19kaXNhYmxlX3VudXNlZCgpOw0KDQouLi4gYW5kLi4uDQoN
CglXUklURV9PTkNFKGNsa19kaXNhYmxlX3VudXNlZF9kb25lLCB0cnVlKTsNCg0KLi4uIHRoZSB3
b3JrcXVldWUgd2lsbCBub3QgYmUgc2NoZWR1bGVkLiBCdXQgb3ZlcmFsbCBpdCdzIGEgbmljZSBp
ZGVhIQ0KDQpNYXliZSB3ZSBqdXN0IG5lZWQgdG8gZHJvcCBsYXRlX2luaXRjYWxsX3N5bmMoKSBl
bnRpcmVseSwgdGhpcyB3b3VsZCBzaW1wbGlmeQ0KdGhlIHRoaW5ncyBhIGJpdD8NCg0KLS0gDQpB
bGV4YW5kZXIgU3ZlcmRsaW4NClNpZW1lbnMgQUcNCnd3dy5zaWVtZW5zLmNvbQ0K
