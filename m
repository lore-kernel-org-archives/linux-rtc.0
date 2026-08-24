Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010039.outbound.protection.outlook.com [52.101.69.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F02D3A450C;
	Mon, 24 Aug 2026 09:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787565503; cv=fail; b=QbGqS4vz03YV3QCu4T0X1REI232OKBp4mLbGJC7t3lWFPVI0h2rxK1njrj7HZoX5p6kuPVf2WEizeu2uwSygqLsuAzNx+iR2Myo9A36sQoOVQtDXwijVTHDPMHQxdtl9TmcRb85QpWLUbGPVN2B+wg8vamcjlSbWHF0laBMDYvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787565503; c=relaxed/simple;
	bh=3QVvUkHuo8F178mDFXX3aFEcgNz+Dgkll4Ny8ECDOwc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Jv3AmOOEpbyfdb3rDdo0zsOsgHetxmHMaeo/ODxTo9e28aLytYnaJAKfDBSRdmOlP3llU67C4n2AOD5zjBYuDYTPAjIQ07TXyc0pxEW2RIrOrPP0B3QsI431wmUMjzF8jZ0RQariN3Buj6k3kXPjkc4/K7co5ZEMELrrNzRQHGU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=j9h42Sy6; arc=fail smtp.client-ip=52.101.69.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="j9h42Sy6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R8GfkOSQZq3kJq9B6dMvvPMFv3zLFeQiCSOUzrmpP7vDmzYN9puIbMtqsuwhLslOKqdlAkZAAEuOprkqxJ+7W2GeBkrB0JqDZvjd1hlKvJkn6wb0X1ywAHduhCbgsK+4kbFDjicWrXUwGdGBRGhBVkisdh8EK7ZHUy+gt3hh01pHFlRPS0/101XLW0nU9rpQjEQ7CZ561cK3oDXhGX9dH6f1caQxCr8PKKH9l6EUF+vIfDwxfxL/L7W87+68GKnc3peCqro3ILJYjIB1KhH8XEh+l3XmlfZ3LsKtuirDU78C+YAf3ihdSnIrA1QuEye4HQdpKvk+x6cp8teoC3XyZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3QVvUkHuo8F178mDFXX3aFEcgNz+Dgkll4Ny8ECDOwc=;
 b=m80Bv/Mwh8uG/qaW594F+raH9mF03XE/y7DgK+RUm+uNjVHsEe8UG43jTYOul9w3tJDWoUCUK3owviXeXbe0CCPRehyd5FhseBvflFd0e0GRZBgwHU0cGbkP27pJTzzGcM6HlfI+RQSgh5sB6Q51UGl7d3AexdZEZH58ywtY1YH1IWHX/e4vEEX28yNa/MkdAoQHhzKGA+DXAFzdwjyVSlI3l6Osk1+OiTuGnSlKyvbOw8wHqPvVrqxWy+QCSTAfXbgLxEgZakHS7Vkg+rSP73ymMFWvXxmW765Tw5+R/+0epHuyRnJKbnsHynTxt5BqOWFIP0tI6UjHDg0tl6u0eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3QVvUkHuo8F178mDFXX3aFEcgNz+Dgkll4Ny8ECDOwc=;
 b=j9h42Sy6FrS0DGrKy6VsmBod+uQov32YYX3mUXe1GmYQoX8MeeM0EPo3GfwUAmID/4BWF1y6scgDW4xgHqIEWPEH1sysac/4bMRjXgBKI7NAqRLletW0RkwecMaTPH/jB48Dmk+ZRQjysXrjOD8mLi5+85l0DAXtrF9TW/lDQuITh1dc/+ziWzUrTShZ9OjXzvyp74vcgDhHQ6KDjGatax5b70ygI59LoPWZoFfto9BtZ9A/Nejl01n0TBMUJueG2NR1xQf17ITsakA+QYKToO07WROCjvrbkHHac3xGVfLKWvm3mJDnm1IwzN+pMjbbyFJWG1bew4ykp46YF6QkHQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by GVXPR10MB8664.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 09:58:16 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 09:58:16 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
CC: "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtc: pcf85063: disable the clkout output by default
Thread-Topic: [PATCH] rtc: pcf85063: disable the clkout output by default
Thread-Index: AQHdM5+zm/6L93bGqUCe6AyZPAteyras3NcAgAAaEoA=
Date: Mon, 24 Aug 2026 09:58:16 +0000
Message-ID: <2ce03d3b4cd9cce8e32fe1fe1ffbea5760bf9ef3.camel@siemens.com>
References: <20260824080801.709764-1-alexander.sverdlin@siemens.com>
	 <20260824082456e0edd7c6@mail.local>
In-Reply-To: <20260824082456e0edd7c6@mail.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|GVXPR10MB8664:EE_
x-ms-office365-filtering-correlation-id: 3167acf3-dbf5-428d-bde9-08df01c637f0
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|18002099003|55112099003|22082099003|5023799004|11063799006|56012099006|3023799007|38070700021|4143699003|10067099003;
x-microsoft-antispam-message-info:
 Q+MPby2f7dEegQpiAUJb5HlWJf/ACtio4PnN2ka8mYo+2sZrLJbgZBdTHLmcmCpnpJNAa7l4/OIclIR3u8RzZ/fqN+ollmPhkAzNHCxhZPMAbTZzQPVJszDk2FbCNvjdGnn6RN/d6BwhDHXij8rFl61RgE0F8+lsECxi5AtY1ifB/Rl3zJkb6OdLf2Whr/Yx0xbwWSDWdZDJJmMIUSvnpKGqKM4c9I3UBJYdTYvG9cr2No3w5ieNQWgrhuUNNmRo812bs283XLfQBipm7VIOFYgHmynJ3KBlA8Nord3XQxCHJFSi8QHc4QzJK9qQKVv+NUwyoQOn5brspKv3MlmR+gbavTwpk9UQ+aqf5ychHyqroZjj9Fj1OaQyEAzFNxxjPUdnYsBdZ53lUOY8ss9wxwSrI2g+thVMWQJu9O010uDW9wpqxGALQaK4CPuCdrgroxQ4IaDYggfY1dYz4w0IpmakJyqusBMlLqX2zhUm/AAneoAQtW1ET/9Ta1HHVHlyUAytD8IW/7jOfVXmpvLkDWBAIWmBQ8dkLKJjXEWw7Br4mnUy9JoZRKN2f+6ipNgzWKaE10FGHiGrlmPva0gQuwWP9zWGjxm7qMIkushc80rwoVccSlsiG8+3tXV2eA7eqpCdLJuCAAxnnsJkKC2SGC8+T7mEit2c0ZTadHczo4M=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(55112099003)(22082099003)(5023799004)(11063799006)(56012099006)(3023799007)(38070700021)(4143699003)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?U3NHNzB4RzJ5WVk0cGx3dS9ON3JhWHV6NjV4ZXUrcS9DTUtnZVNxTG94RzBH?=
 =?utf-8?B?eDBxSGFWOE4ya2tNdWVHOUx2RE1YTWQ1MUdMTXpoalJNdzZJU1c5eURMcEVs?=
 =?utf-8?B?WnM4MlExeEhUa3BGdEFQWVNtVXV3UWZmZXZDZGppOEJrN2w1NGxVNjA5NTBD?=
 =?utf-8?B?djM2SVJFc0hGd3N6OTJqS2N0blRuWjk0UFgyb0ZTL2thYU5OcS9sM2loQUpJ?=
 =?utf-8?B?aGIzalppak9KSEtqSHpvNGNUTXkyQ1BnbXE5QXN6SFdZVWJndTkwZDR3Ujcw?=
 =?utf-8?B?bTZ2V3hHSCs2Q29yV2dUc2UybTRNVzhpdk1qUTFBdnpvWXdjSnFYRnMxWVU3?=
 =?utf-8?B?OEoySmxWREw5aGZjTzJDUmtiWEg2Q2U4RUZ5Yy9adEFremJiS285MFNRNUp1?=
 =?utf-8?B?KzY4bTFkdVJtOFMyZHVESUVKb0xLMkZvK2swNXQrRUxIT0dDY3RYdlpsSElL?=
 =?utf-8?B?VFMyRHRtQ3FsdmhOT082L2YxVjIrNlJaa2ZNcWdxTkljWEp4VmphNnRRamo4?=
 =?utf-8?B?R3E5Vm0yUkVCMEZ2czZTazVKbitIMDNYMnU3K1BkYTNXNWpIVFg1TllDSE80?=
 =?utf-8?B?OUdVbkRkL0hRZWdJdHVXbDBzc3VUaHdzZ3hJSURyc3VnMnZHdUFFcnVMWkxR?=
 =?utf-8?B?bEY5L214dlVCZE1CRXlFTDlyU0UvVnpCM01XQ25sNHdrU3I2eVE5bzhLOGJi?=
 =?utf-8?B?QStxOWhCQTNLbS9CWnBZSmRyVmc2R3JzN1VTc2gyQzRJVWE5Nmtvam5TY3oy?=
 =?utf-8?B?dzFMa0xmQnhSeTFBT0xHejU1WndxMmJFUWlneXNZWFRoWHdmNnpjZ3AzT3Nj?=
 =?utf-8?B?MEJqTXpuOWpEaFVqbEowd1BWNGppZ05SVHphNklCa2hER1dDS1IvV0NXUGFH?=
 =?utf-8?B?c0hEckdiUmp0NDg2eFVaQWs4NU5ZUFNyYTNaTXZlYloycnNUeVdIbk1PVk1F?=
 =?utf-8?B?cVFuRmUzY3dLMkNoWWNNWThTN2lPUVl4UUxGU294bDh5WW41Q0l2ZkV1TE90?=
 =?utf-8?B?UWxEMGtkSnlHVVJtejRUMEdsT2NmNEVGbllZOHdabUx3UDdjS2tlSjNZZVpI?=
 =?utf-8?B?WTA3ZDFSUS9SSzBDTnJSc3FCN2twQ3pIdnVoSk1sV0JhdEs0S0lZeXdySXVR?=
 =?utf-8?B?OW5od0VCQnh3VVVHVjdwT2RLWDZDcU9XbUJUbC9WMHpLZmZIRHhwZDdKcEwz?=
 =?utf-8?B?WFRyQ1lGd3ZCb2xjRUNsenQyNURWdUpxbWJaY0ZLZ0xVbWZMTE5NWFdna2dr?=
 =?utf-8?B?ajFlQWtoc0xnL1dyMnI5ZUtvaDgrcG9JeCsrTUlMaVdleXh3aXNvaFZjeVBV?=
 =?utf-8?B?RUxNL0tyVnlKQXhtUkdiVXUxc24xYUFSOERtc2ZoN2dJMVBYN0RmL3R4cFJZ?=
 =?utf-8?B?RE1Kbm5nb2lUeVFRbVhGbHVFa016YmUyMU5sZjdRVUVmVHZUS1RDQktVbDJ1?=
 =?utf-8?B?V3JsajFOSEdDdnJDYnFIcGZoblpGTEd5dHJ0YkF0TlRXUGllcFVxZzRXM0NV?=
 =?utf-8?B?TXlWNnVKdFJzSXYzUVhrK3hQMUdpbkY2TjFBdUJtWFJaTmE0Z1Fxb3RZTE41?=
 =?utf-8?B?RmNjK0dETDZLdXdNUy92OUtRckJwa2JOT0hUOEsycFBKN1pEYXM5WElaMUtn?=
 =?utf-8?B?YWJzSEZKZ2o2RE41SnhiTU1YdmF4QllIVjNCSGRQNjIzQ1B5NXdJcG10ZWFX?=
 =?utf-8?B?TnlTMS8zMXc3T1NGUXpTVWV1MTh4M3M1WkltOEI2MnYrbi9KTTFiRkNMMzRB?=
 =?utf-8?B?OTBFQldMY09TSFJ6ZFNwcW5hS1ByczVORWJRbk5TRGlEc2ZDSXYxWkUwQ1NV?=
 =?utf-8?B?VEx6dWFvWkszWWdueWQ3aFN2U1ZYdTVmWUYrVFUwY0dQNENuTEtCeXNsSVQ4?=
 =?utf-8?B?VzYzMnhuTjFWNUF5QUJ3TDVieGZSb1VZT3hqckZ6RWp6Z3FIZThSS2RoT2ht?=
 =?utf-8?B?UHhBRks4MjlrSE5WZmFIa3c0bTRvSEpXcEthM1h1TDg2RitScHpqbUNlQUs5?=
 =?utf-8?B?bDExb1psL1djcGtRekFGNklYVGkxSEYyVFRjd3k0alhsNlEyTzY5eHpsN0xQ?=
 =?utf-8?B?THhuVnVSQUZLTk1ERklDVytlZ3BVOVhLUFBkSC9WYlRUK2tWRWJtSVV4Wncr?=
 =?utf-8?B?U1dyU2dVSlVTaXI1ZVNyckNpbHdvSS92NXEyVG82N0pHbXl4V1UwOWF5d3g5?=
 =?utf-8?B?bXVqVVlzZFpGNkFyQnBvUHZ1OEhJQ3NSZDBPMjREZllFYW9lZ01XVjdtd0NS?=
 =?utf-8?B?K2ZNT0hwVmFzR1AvU3YzTE1ITHYwUXR4alFmTXoxcThRaFNFYnhKQ2NVNHVV?=
 =?utf-8?B?V1d0amJreDAvemF3UnhFaCtJVlNETHFGaHRCV0J2N2g4NzNpbDNIQzZnTlFE?=
 =?utf-8?Q?ZE6WbSjrFw181Yh8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <207F02FACA1E2041B56EF14AB77488DA@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3167acf3-dbf5-428d-bde9-08df01c637f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2026 09:58:16.2999
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: slyJGaTdjq9p+jWk209WDDSfpwaZXds5ZR7hughMLT5+/Sv8+UlwtV+Q/cYP006klVfWNAgTrwzwqmX00zLPm5xLYQlA7h5Z7v5o/7Ng/BI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8664

SGkgQWxleGFuZHJlLA0KDQpPbiBNb24sIDIwMjYtMDgtMjQgYXQgMTA6MjQgKzAyMDAsIEFsZXhh
bmRyZSBCZWxsb25pIHdyb3RlOg0KPiA+IEZyb206IEFsZXhhbmRlciBTdmVyZGxpbiA8YWxleGFu
ZGVyLnN2ZXJkbGluQHNpZW1lbnMuY29tPg0KPiA+IA0KPiA+IFRoZSBQQ0Y4NTA2MyBwb3dlcnMg
dXAgd2l0aCBpdHMgQ0xLT1VUIHBpbiBkcml2aW5nIHRoZSAzMi43Njgga0h6LiBXaGlsZQ0KPiA+
IGl0J3MgcG9zc2libGUgdG8gcmVxdWVzdCBhIHNwZWNpZmljIGRlZmF1bHQgZnJlcXVlbmN5IGlu
IHRoZSBEVCB2aWENCj4gPiBhc3NpZ25lZC1jbG9ja3MvYXNzaWduZWQtY2xvY2stcmF0ZXMgb24g
dGhlIFJUQyBub2RlIGl0c2VsZiwgZXZlbiB3aXRob3V0DQo+ID4gYSByZWFsIGNvbnN1bWVyIHJl
ZmVyZW5jaW5nIHRoZSBjbG9jaywgdGhlcmUgaXMgbm8gc3VjaCBwb3NzaWJpbGl0eSB0bw0KPiA+
IGRpc2FibGUgdGhlIGNsb2NrIG91dHB1dCBieSBkZWZhdWx0Lg0KPiANCj4gQXJlIHlvdSBzdXJl
IGFib3V0IHRoaXM/IFRoZSBDQ0Ygc2hvdWxkIGRpc2FibGUgdGhlIGNsb2NrIGlmIGl0IGlzIG5v
dA0KPiB1c2VkLg0KDQpUaGVyZSBpcyBsYXRlX2luaXRjYWxsX3N5bmMoY2xrX2Rpc2FibGVfdW51
c2VkKSAobWFya2VkIF9faW5pdCksIGJ1dCBmb3IgdGhlDQpjbG9jayBwcm92aWRlcnMgcmVnaXN0
ZXJlZCBsYXRlciwgc2F5LCB2aWEgbW9kdWxlcywgdGhlcmUgaXMgbm8gc3VjaCBtZWNoYW5pc20u
DQpBbmQgSSBkb3VibGUtY2hlY2tlZCB0aGlzIHB1dHRpbmcgc29tZSBkZWJ1ZyBwcmludHMgaW50
byB0aGUgZHJpdmVyLA0Kbm90aGluZyBmcm9tIHN0cnVjdCBjbGtfb3BzIGlzIGJlaW5nIGNhbGxl
ZCB3aXRob3V0IGEgY29uc3VtZXIgaW4gRFQuDQoNCj4gPiBUaGVyZWZvcmUgZ2F0ZSBDTEtPVVQg
aW4gdGhlIGRyaXZlciBiZWZvcmUgcmVnaXN0ZXJpbmcgdGhlIE9GIHByb3ZpZGVyLA0KPiA+IG1p
cnJvcmluZyB0aGUgcGNmODU2MyBhbmQgaHltODU2MyBzaWJsaW5ncyB3aGljaCBhbHJlYWR5IGZv
cmNlIGFuIG9mZiBzdGF0ZQ0KPiA+IGF0IHJlZ2lzdHJhdGlvbi4gRG9pbmcgaXQgYmVmb3JlIGRl
dm1fb2ZfY2xrX2FkZF9od19wcm92aWRlcigpIGxlYXZlcyB0aGUNCj4gPiByZWFsIGNvbnN1bWVy
cyBpbiB0aGUgZGV2aWNlIHRyZWUgZnJlZSB0byByZS1lbmFibGUgdGhlIG91dHB1dCBhZnRlcndh
cmRzLA0KPiA+IHdoaWxlIGFuIG90aGVyd2lzZSB1bnVzZWQgQ0xLT1VUIG5vdyBzdGF5cyBvZmYu
DQo+ID4gDQo+ID4gSW4gcHJhY3RpY2UgaXQgbWVhbnMgdGhhdCB3aXRoIENMS09VVCBkaXNhYmxl
ZCB0aGUgUlRDIGNvbnN1bWVzIGFyb3VuZA0KPiA+IDI1MG5BIGF0IDI1wrBDIGFuZCA2LTEwdUEg
d2l0aCBDTEtPVVQgZW5hYmxlZCAoNXYgVmRkKS4gV2hpY2ggbWVhbnMgZGF5cyB2cw0KPiA+IGhv
dXJzIG9uIGEgc3VwZXJjYXBhY2l0b3IuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogQWxleGFu
ZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5Ac2llbWVucy5jb20+DQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvcnRjL3J0Yy1wY2Y4NTA2My5jIHwgNiArKysrKysNCj4gPiAgMSBmaWxlIGNo
YW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3J0
Yy9ydGMtcGNmODUwNjMuYyBiL2RyaXZlcnMvcnRjL3J0Yy1wY2Y4NTA2My5jDQo+ID4gaW5kZXgg
MDFlMjA5ZDg4ZjVmMy4uMGI2ZDgwODNiNjQ1NiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3J0
Yy9ydGMtcGNmODUwNjMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcnRjL3J0Yy1wY2Y4NTA2My5jDQo+
ID4gQEAgLTUyMyw2ICs1MjMsMTIgQEAgc3RhdGljIHN0cnVjdCBjbGsgKnBjZjg1MDYzX2Nsa291
dF9yZWdpc3Rlcl9jbGsoc3RydWN0IHBjZjg1MDYzICpwY2Y4NTA2MykNCj4gPiAgCS8qIG9wdGlv
bmFsIG92ZXJyaWRlIG9mIHRoZSBjbG9ja25hbWUgKi8NCj4gPiAgCW9mX3Byb3BlcnR5X3JlYWRf
c3RyaW5nKG5vZGUsICJjbG9jay1vdXRwdXQtbmFtZXMiLCAmaW5pdC5uYW1lKTsNCj4gPiAgDQo+
ID4gKwkvKiBwb3dlci1vbiBkZWZhdWx0IGlzIHRoZSAzMjc2OCBIeiBvdXRwdXQgb247IGdhdGUg
aXQgdW50aWwgY2xhaW1lZCAqLw0KPiA+ICsJcmV0ID0gcmVnbWFwX3VwZGF0ZV9iaXRzKHBjZjg1
MDYzLT5yZWdtYXAsIFBDRjg1MDYzX1JFR19DVFJMMiwNCj4gPiArCQkJCSBQQ0Y4NTA2M19SRUdf
Q0xLT19GX01BU0ssIFBDRjg1MDYzX1JFR19DTEtPX0ZfT0ZGKTsNCj4gPiArCWlmIChyZXQpDQo+
ID4gKwkJcmV0dXJuIHJldDsNCj4gPiArDQo+ID4gIAkvKiByZWdpc3RlciB0aGUgY2xvY2sgKi8N
Cj4gPiAgCWNsayA9IGRldm1fY2xrX3JlZ2lzdGVyKCZwY2Y4NTA2My0+cnRjLT5kZXYsICZwY2Y4
NTA2My0+Y2xrb3V0X2h3KTsNCj4gPiAgDQo+ID4gLS0gDQo+ID4gMi41NS4wDQo+ID4gDQoNCi0t
IA0KQWxleGFuZGVyIFN2ZXJkbGluDQpTaWVtZW5zIEFHDQp3d3cuc2llbWVucy5jb20NCg==
