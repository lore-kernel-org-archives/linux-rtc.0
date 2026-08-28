Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011015.outbound.protection.outlook.com [52.101.70.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF324373BE7
	for <linux-rtc@vger.kernel.org>; Fri, 28 Aug 2026 17:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787937667; cv=fail; b=IpiXUwkAPJZ7ZpF1y5oTCBumcB+qNB5IYCuhiyunMOKzMcz2XkcDspk4r9r1kwhnWs3YfnyhvDf7awZ6mBn6AiREZVi5t68XgORI22EfJVP3L5FLBU90rbI6R8pdwJT7TJZtnjT05DChwnZ5+2dR8c8BSI1gz/jGN+uDGf81I5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787937667; c=relaxed/simple;
	bh=yvkrCvbxPBikHkWAPBN2XPksE4oh2Uo40EuZTgIxJtA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r3F3YUP07LZYiRqH3KTODe1CnfZsDhB2AXGWoSe69LeSNzkJC0zCJF+z78oRnqvBBVYnBq+897jQgn6MnNPtI7MKMTRF327iB65OIGZF2cSwOqOuAV3XoS8/RHfa4vduyMr7k7IcLPqCdraUZ/n5VwAuX/j5AXGiQ00kr/9J4ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=QjhAXQeF; arc=fail smtp.client-ip=52.101.70.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="QjhAXQeF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ceANgLtpXJegRw9CKKfwgAwrWy1Sw72E/9u9KNec8Dg96OFv5EeSGh8y3cF2Fr7Wl0+E1re5P1DVcfRKGD40LtWUXGJgVB3Hvdoy+7It7PVv2NYlt7t0JfygYrPfBBY4OkIOdPFUKxqfR3t2HlkJd2t7bfaA3ZDeWFxtKEJlY6c3vFLU6sB6JANvUG79mOjAJWhD+vlDdQHAT0D2pMqX3qBBrYcM6y4D2qO2RIhXXq/SMCwmsUf2LtW4vcHo/fDC0we2qfTiGUbROTSCM1DuKo6YXaE5l6T3ETsCfJeX02ZK9c+IkHTeiy/4aTiLvzeZVOQB22pUx3ERZysFSJ+8GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvkrCvbxPBikHkWAPBN2XPksE4oh2Uo40EuZTgIxJtA=;
 b=NIUf/D88VUa3zs4IDcRj83X7N9EtmzrcRmT7LpkFRwOwhn1tq22Y0LgT6bxin+hfyDgEhuBL1hDTavcgr83b6IvF+RgphT6swfbL0geMkSX9O3QpNwnXqKyLOcBNETGWWXkmbIN4+Aop6atWXatGwD1CZSTXtp9PillQEbKOXduDYyuvX5HYp+J+ua6XrJ4gc8dKio5J3ecNjit2nKx5XFY4cTipV970PEfQg6ce0cH+Df7gZcofrl2qj6CRVBnS+erYdVxImgIGfnq0KjT0uniNb8424uFu99FsA9o8QSO3j7vOaNP3t9jJb2RigFJy5z1+UHM8XYUlHe9FSCnA5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yvkrCvbxPBikHkWAPBN2XPksE4oh2Uo40EuZTgIxJtA=;
 b=QjhAXQeFf8BznV/cThmqlpX6qA9PzOr9eXcsrFNnc6lSZ0QAvAXqR9drzGUhqAUgT1M4YbwkrDpjVQr3djUN9/FCd/Tuy5E8vOsKw70blNbqMN/QYwYx8uq2Dvvq/Aj8qeIh2TOw1l5SbbV6eG1aBNoRaQCuOOyE+wjgqMqi+ej4kbZcddyFUR3coX70ohYNEq/F8MHW2mJt/KYsTn/+uCt+fHCgOuIW74pXWCwYgxaVFm+XtmTSa+RkTD8fEZWZqsxnlt240Vctsa6+H53IjSm4gsu2AEKs1ZbGZ6xd9VJqWorPjAn+vzznIh0J7kEG0d1dQar9zcxpkl1ouQIrNQ==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by AS2PR10MB6520.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:55c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Fri, 28 Aug
 2026 17:21:00 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9126:d21d:31c4:1b9f%6]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 17:21:00 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "sashiko-reviews@lists.linux.dev" <sashiko-reviews@lists.linux.dev>
CC: "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
	"alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH v3 3/4] rtc: pcf85063: preserve the alarm flag in clkout
 register updates
Thread-Topic: [PATCH v3 3/4] rtc: pcf85063: preserve the alarm flag in clkout
 register updates
Thread-Index: AQHdNwyLWeGKYuG28ECqJ6Y/NSaZf7azruoAgAAGKYA=
Date: Fri, 28 Aug 2026 17:21:00 +0000
Message-ID: <1c69cb2bd8cff32853428fedf3773d430c8287b5.camel@siemens.com>
References: <20260828164445.3907839-1-alexander.sverdlin@siemens.com>
	 <20260828164445.3907839-4-alexander.sverdlin@siemens.com>
	 <20260828165854.DF87C1F000E9@smtp.kernel.org>
In-Reply-To: <20260828165854.DF87C1F000E9@smtp.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.58.3 (3.58.3-1.fc43) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|AS2PR10MB6520:EE_
x-ms-office365-filtering-correlation-id: 5eefaa56-2655-484c-a087-08df0528bb3f
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|10070799003|376014|1800799024|366016|10067099003|22082099003|18002099003|55112099003|11063799006|4143699003|56012099006|38070700021;
x-microsoft-antispam-message-info:
 qItSOklMn0zULisi47yK2jXvNcpuIo/oLXAV5vuKG75oDRkdibeKrO0VCRkv5Tl0pgaQSmoiPdQs0m5kvZE+kMcUj7MvzWF3bP1Y802DSzdTOTISJLyh2fIwuSvL+ozR3/kdqr0tfe0sj/reoVtIuwz6gEz0RjH/bXQ4W7jVEMjFBvWVdqz4+LNvyaCVABxNtTCQ+oOXraiXeN5Zbsw1hQsHnG5emImUCcmJNHhwIo92oW0rsyw/mNrZOtSIFYjU+yaHot8pMyy+o1zuxRqKtKAHS/ZhKBvqpHAKXJ1MBLdKTt5PNqLqamwNz7R2NCtr9q0sxZndpcpJIN2SVvEPzp8x66FiKLEWyw99pNoUbTL5Io+zJJKeXqmSK32dFXAVK8Q3/imwdS/TQQ1vPe6MNoXQkjq4FcFPBS175VzW4bGNuyEpQZSfREJ1lt3wBmDojk2lKeQOMBDh1ASG78y4ZpgrxKbxSpehD4yNOLZTJ4fdh9vSPBX4ZDrrk9AoeAYeaHGpL0ZXTHmBUt1sYGRP7FdUCL8vzGgj+EL1UBmA/8K4ROjxlkNvUGj9Bd3Y60ax09q08Dy+gnw4aU8HEy7b9U/mWwYSZmMbnFgZvOL6vkDckl3/a8PXcsaRzJKzD5Lzzv8AmgsKKCx8shvrQus/AhP+96wpB6aWGs+eubIcdsY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(10070799003)(376014)(1800799024)(366016)(10067099003)(22082099003)(18002099003)(55112099003)(11063799006)(4143699003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RjRCdHk2RnNabVZnMGNtVDl4ZmJzZ1d1aVg1Y253UTJOK3R0aUZIUTIzNUJ2?=
 =?utf-8?B?T0FITStMWEJVamIwbVVwcmh1RThWa2d0REl1Vk9qRUJHcjAzeUxCSFAzVUFy?=
 =?utf-8?B?ZmZHSEl3UHZPWWJoQlpQcFdzcEplSU5OWUVVaURGd0pYRHZtSEYyQ3ZaNkZP?=
 =?utf-8?B?MDJjYm1MRnl3c29OWlFGK3Zsa3oySjAwbUdiS3pDUnFRcXlwSFdkS0xQU0Vu?=
 =?utf-8?B?MGJ6ODNCemJrb1Z0Z2pLM3V3aW9nemJOMnZJbkxLOFNLWC9NZDRiSzI0d0dR?=
 =?utf-8?B?WE5md3lPWmg3bytvTVJHbDJtRzYwVWhCcS80RC9Tdmx3RmhybFc2NmxjSGFJ?=
 =?utf-8?B?UUN5c0JjVEY3Ukd1QUZWcGlqRXgwMXdxN2pEc2VpcUIvRXJLS2t1cVNmdSsv?=
 =?utf-8?B?b3o1Rk9paHkzbU9ENnNMNFF5YUtNc2FTVGZvNXJPYlJ0cm5WQXkxU2N0dHpZ?=
 =?utf-8?B?aTFvc2dkMGo2bDRSc3dDSWw1ZjVoR21GWmNWWlZLL0gvZlBDTC9KbHExTU04?=
 =?utf-8?B?bmFaeVpHbTV5WjVmeGF5RUtSOG9nRmpGaXE1dU5TUGFQWEtTR2F1MXNDbWp1?=
 =?utf-8?B?UTlRQzAzRGt2d2svS2RpelBzUXRjc0UvcG5BQXFVc3I5c3ZCVm9OSFJ0Ni9l?=
 =?utf-8?B?VDdjc1crbndrYmZXNXJabVNhRjBpelNLUG5seEtoWFVLZGxyaENhYkN5UE1H?=
 =?utf-8?B?SERLVVZ0SzkxR2NLcXNIK3kzaFN6QnJnbGU2OWJTZmJCaW1WOUt6eUpkcnZY?=
 =?utf-8?B?d3pvaGVIL2NnWXU5bjFoZlNaYitrWlJPMVJORWpRaEU5YWNsWk0wMGhaL3dB?=
 =?utf-8?B?T2IwckJtbEtNZU4xTmFSMjZCWmZXZWhQZW9aWEJVME1PcGdLbDFyd25SYWVo?=
 =?utf-8?B?ZTJmbTM2WE1BMHVtTnlQOE45MUdZSVg3UDFtS3I3ZExJM2VUaXQ3ck1sTU4z?=
 =?utf-8?B?bnJ5QlVlWGNXUlI0M0xqejFQSEJVT3JmS0RXSmxrbzd0Mk45dTNoN1Q0OHpK?=
 =?utf-8?B?S1l4dk4wSEdJOHN5M09GcENaUy93R2s5K3VwbUJEZTJ2dVZLUExYL3EvbUdF?=
 =?utf-8?B?aDRFaUhad2oyYnZGUllFZUE0enV3Z2g4YjdEUVo0NzRHWFliVUQrc1JGWkNS?=
 =?utf-8?B?eXprRDhWNStleGRINUZDQnRiSkRlNlJ0a1pUSjgzTUFETm5jVFBQc3FPdUxF?=
 =?utf-8?B?NDAvd05IS2xkbkZ0R2F1YklWTEMwa3o1TWdrQnBqTXRRZEExY3F2ckFGK01K?=
 =?utf-8?B?eWlXb3JRMXA2elk4WDJ4M043Y3FXOU1BUXNRNjFXNDNiMnVJQ3lYMEM4Ykw5?=
 =?utf-8?B?My9oWkVpYUxrM3FWZm5jQjl4aS82ZmRWajhXbTBjblp3YTlEVmRIWEp2UjBu?=
 =?utf-8?B?cHJtWmJZYTJxY3luRDVXZzFGVm9mVENHOVpYWU5YamEwYW9vTkVJeEZKbG5O?=
 =?utf-8?B?NGJTYkpKcWdOakFZN2tWN29jRThsVWVpdzhKaEFURjRvbkJZM1VCZ3BRd0VQ?=
 =?utf-8?B?aTRyZDlwdldiUFRqN0tzMVN1anByOEVxWHA3TjVrSlA4OFFNejF0MUMzUzNL?=
 =?utf-8?B?S0FUU1pUUjdYVnVFc1psa2Vqc0xXN3cyV0NyNE5ZRFJOYkVCWWhNTVIzZEU3?=
 =?utf-8?B?UThlYkl4SUVOUzNPRkRHdU91UU9NNFhaQ1d0Z0pNaVNUVDBsNlZUaWs0blps?=
 =?utf-8?B?Qk1kUEpXWVpnY0t6eEhya2lMV2ZMaWpiLzRJQS9yaFRFbXRXUWZKRXlqeFlN?=
 =?utf-8?B?VjZnaFhqbHlhbUJaT3JBcXNYZzN2RHhPMUk0MG9hT0FKUjcvV28wMHlLTDJh?=
 =?utf-8?B?RTZlbmxwSks2WWZFYWJremtXVHZvQTBJTzJiTnJ3TFZ1UElCZlN5UE5US0w2?=
 =?utf-8?B?MkFDakFXUDJrZy83T05lbzRneFRoL2JGR1YrYnRWVWpXaWFENkhwSGNEeExz?=
 =?utf-8?B?aGc5QXNzZDZoRWtEdFYxNkhrVnduRTlXR1BtL09EZ3hwb3dHWEZVajNGZEc2?=
 =?utf-8?B?Q0EzNVJ3UmxBK2ttTDlhVU90NThPd0h0dUFGaFRPZHh2Ny9hTjVER3JWa2lh?=
 =?utf-8?B?NzdMd0tvcEcxTnBZM3pPWVBMSTU2ZW1LSFgwUTlGbnIyTXljdWhRVGh4TkIr?=
 =?utf-8?B?Uk8wNURQQ2RHYjdQdzdRVVdWZEdmQUUrODhLWW5FYytsd3k4TTQrWk9rWDg1?=
 =?utf-8?B?NDE4WXhveUM2cVNBS3lQeGNtaHc4WHk5UFhxYjZhbFBlRlhIOXpWTlEvNkxF?=
 =?utf-8?B?YlZGUDdSakZVUHpWbm5XSkF6b0hBNVA0cTV6VnNqazlkcXluM3I1TXo5N0w0?=
 =?utf-8?B?MW51T2lkTzNydmZhcmJyQWV2MDdzbXVKM2pGRU1CT1BGUndnVmNLYTIrYlZG?=
 =?utf-8?Q?SbonPz0O57btBiqbu97SvTUXv0riGlAQkjHQhc9fRjvQw?=
x-ms-exchange-antispam-messagedata-1:
 QmBX43y9IHqR+sRbE5ivRh37iHGzuW4Y75fdMzT8G6h1/2Ms4DgeRGPq
Content-Type: text/plain; charset="utf-8"
Content-ID: <D4893055FB39C741BD8684BB59955139@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eefaa56-2655-484c-a087-08df0528bb3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2026 17:21:00.7977
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7M8rxkjdM7zMwL6lAzlgEe2Hhr9PXY3LiSgllkPNAk1IE4GWfzoam6z3fVs+KBulMbnUi7j54+NipjenK88GhN/2yYVzpSKPpM717dxBODk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB6520

SGkgYWxsLA0KDQpPbiBGcmksIDIwMjYtMDgtMjggYXQgMTY6NTggKzAwMDAsIHNhc2hpa28tYm90
QGtlcm5lbC5vcmcgd3JvdGU6DQo+IFRoYW5rIHlvdSBmb3IgeW91ciBjb250cmlidXRpb24hIFNh
c2hpa28gQUkgcmV2aWV3IGZvdW5kIDEgcG90ZW50aWFsIGlzc3VlKHMpIHRvIGNvbnNpZGVyOg0K
PiANCj4gUHJlLWV4aXN0aW5nIGlzc3VlczoNCj4gLSBbSGlnaF0gVGhlIHBhdGNoIGNvcnJlY3Rs
eSBmaXhlcyB0aGUgcmVhZC1tb2RpZnktd3JpdGUgcmFjZSBjb25kaXRpb24gZm9yIHRoZSBhbGFy
bSBmbGFnIChBRikgaW4gdGhlIGNsa291dCBoZWxwZXJzLCBidXQgaXQgY29tcGxldGVseSBtaXNz
ZXMgdGhlIGV4YWN0IHNhbWUgYnVnIGluIGBwY2Y4NTA2M19ydGNfYWxhcm1faXJxX2VuYWJsZSgp
YC4NCj4gLS0NCj4gDQo+IGNvbW1pdCAxMDk0MWM4YTBjY2UwYzRhODA2NWMxYzlkYThjMDkyYjY2
ZGYwMjgyDQo+IEF1dGhvcjogQWxleGFuZGVyIFN2ZXJkbGluIDxhbGV4YW5kZXIuc3ZlcmRsaW5A
c2llbWVucy5jb20+DQo+IA0KPiBydGM6IHBjZjg1MDYzOiBwcmVzZXJ2ZSB0aGUgYWxhcm0gZmxh
ZyBpbiBjbGtvdXQgcmVnaXN0ZXIgdXBkYXRlcw0KPiANCj4gVGhpcyBjb21taXQgZml4ZXMgYSBy
ZWFkLW1vZGlmeS13cml0ZSByYWNlIGNvbmRpdGlvbiBmb3IgdGhlIGFsYXJtIGZsYWcgKEFGKQ0K
PiBpbiB0aGUgY2xrb3V0IGhlbHBlcnMgYnkgZW5zdXJpbmcgQUYgaXMgcHJlc2VydmVkIGR1cmlu
ZyByZWdtYXAgdXBkYXRlcy4NCj4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcnRjL3J0Yy1w
Y2Y4NTA2My5jIGIvZHJpdmVycy9ydGMvcnRjLXBjZjg1MDYzLmMNCj4gPiBpbmRleCBhZjkwMGZl
OGFlMTVlLi5hM2FmODY0NTZjY2ZjIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcnRjL3J0Yy1w
Y2Y4NTA2My5jDQo+ID4gKysrIGIvZHJpdmVycy9ydGMvcnRjLXBjZjg1MDYzLmMNCj4gPiBAQCAt
NDMxLDcgKzQzMSw4IEBAIHN0YXRpYyBpbnQgcGNmODUwNjNfY2xrb3V0X3NldF9yYXRlKHN0cnVj
dCBjbGtfaHcgKmh3LCB1bnNpZ25lZCBsb25nIHJhdGUsDQo+ID4gwqDCoAkJaWYgKGNsa291dF9y
YXRlc1tpXSA9PSByYXRlKQ0KPiA+IMKgwqAJCQlyZXR1cm4gcmVnbWFwX3VwZGF0ZV9iaXRzKHBj
Zjg1MDYzLT5yZWdtYXAsDQo+ID4gwqDCoAkJCQlQQ0Y4NTA2M19SRUdfQ1RSTDIsDQo+ID4gLQkJ
CQlQQ0Y4NTA2M19SRUdfQ0xLT19GX01BU0ssIGkpOw0KPiA+ICsJCQkJUENGODUwNjNfUkVHX0NM
S09fRl9NQVNLIHwgUENGODUwNjNfQ1RSTDJfQUYsDQo+ID4gKwkJCQlpIHwgUENGODUwNjNfQ1RS
TDJfQUYpOw0KPiA+IMKgIA0KPiA+IMKgwqAJcmV0dXJuIC1FSU5WQUw7DQo+ID4gwqAgfQ0KPiA+
IEBAIC00NjAsNyArNDYxLDggQEAgc3RhdGljIGludCBwY2Y4NTA2M19jbGtvdXRfY29udHJvbChz
dHJ1Y3QgY2xrX2h3ICpodywgYm9vbCBlbmFibGUpDQo+ID4gwqDCoAl9DQo+ID4gwqAgDQo+ID4g
wqDCoAlyZXR1cm4gcmVnbWFwX3VwZGF0ZV9iaXRzKHBjZjg1MDYzLT5yZWdtYXAsIFBDRjg1MDYz
X1JFR19DVFJMMiwNCj4gPiAtCQkJCQlQQ0Y4NTA2M19SRUdfQ0xLT19GX01BU0ssIGJ1Zik7DQo+
ID4gKwkJCQnCoCBQQ0Y4NTA2M19SRUdfQ0xLT19GX01BU0sgfCBQQ0Y4NTA2M19DVFJMMl9BRiwN
Cj4gPiArCQkJCcKgIGJ1ZiB8IFBDRjg1MDYzX0NUUkwyX0FGKTsNCj4gPiDCoCB9DQo+IA0KPiBb
U2V2ZXJpdHk6IEhpZ2hdDQo+IFRoaXMgaXMgYSBwcmUtZXhpc3RpbmcgaXNzdWUsIGJ1dCBkb2Vz
IHBjZjg1MDYzX3J0Y19hbGFybV9pcnFfZW5hYmxlKCkgYWxzbw0KPiBzdWZmZXIgZnJvbSB0aGUg
ZXhhY3Qgc2FtZSByYWNlIGNvbmRpdGlvbiB0aGF0IHRoaXMgcGF0Y2ggYWRkcmVzc2VzPw0KPiAN
Cj4gTG9va2luZyBhdCBkcml2ZXJzL3J0Yy9ydGMtcGNmODUwNjMuYzpwY2Y4NTA2M19ydGNfYWxh
cm1faXJxX2VuYWJsZSgpOg0KPiANCj4gCXJldHVybiByZWdtYXBfdXBkYXRlX2JpdHMocGNmODUw
NjMtPnJlZ21hcCwgUENGODUwNjNfUkVHX0NUUkwyLA0KPiAJCQkJwqAgUENGODUwNjNfQ1RSTDJf
QUlFLA0KPiAJCQkJwqAgZW5hYmxlZCA/IFBDRjg1MDYzX0NUUkwyX0FJRSA6IDApOw0KPiANCj4g
SWYgdGhlIGFsYXJtIGZpcmVzIGV4YWN0bHkgZHVyaW5nIHRoaXMgcmVhZC1tb2RpZnktd3JpdGUg
b3BlcmF0aW9uLCB3b3VsZG4ndA0KPiB0aGUgaGFyZHdhcmUgYWxhcm0gZmxhZyAoQUYpIGJlIGlu
YWR2ZXJ0ZW50bHkgY2xlYXJlZCBzaW5jZSBpdCBpcyBvbWl0dGVkIGZyb20NCj4gdGhlIG1hc2s/
IFRoaXMgY291bGQgbGVhZCB0byBhIGxvc3QgUlRDIGFsYXJtIGludGVycnVwdCBhbmQgY2F1c2Ug
dGhlIHN5c3RlbQ0KPiB0byBtaXNzIGNyaXRpY2FsIHdha2V1cHMuDQoNCkkgYmVsaWV2ZSwgdGhh
dCdzIGludGVuZGVkIGJlaGF2aW91ciwgdG8gY2xlYXIgdGhlIHBlbmRpbmcgaW50ZXJydXB0IGZs
YWcgb24gZW5hYmxlLg0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBBRw0Kd3d3
LnNpZW1lbnMuY29tDQo=
