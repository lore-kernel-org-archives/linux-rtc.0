Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792753197;
	b=uGlkpRhYorQDbnQioyTK5Ku91XuEEqI/9eRzmH5qXLVmbSqLZMpiI91ozIdZdPCSFLMg
	 +dsZMhh3lLerqKze2Y0JREBev+bb4/2unJ1PUCRSyhXvS06NvHrN7tzt59U8d3SZyoA1K
	 hw+xRyVLvFP2fp/5PKdmqTsDOi5gXqwVkMtR9jY/LH3LLN8zBLRqgfIdY1YM9DtnhiSnC
	 m/c90lKFQQIHe94fqE3HU2l8MSQ/M9YhYmrUBMm93fPj19PGKAWrvQ6XaHPFFq3PRtVji
	 GSbbIC5E5XwOVQ6ZgPYcsnCxcXmzrlvJp7YnQtnFq34ySF4csep+LkyLiLloIy9MqhA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792753197;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=AZHMsf9MaFL5RcOokb0S1vsfdFBgDY+pPXwYE6SPgnY=;
	b=lrb3o6ftJZQyddF9NAkYPn6BjW2BRhWxt3ZbUrp/jJCArQBzweuZ/KFstgekNAyfgdVi
	 nG4FndGnFZvyNimqGX3lQdVh7FjzVvi/ru1bpwD9NkUNtccgimZDOYCg8x7GrFIcwwdRc
	 zkMNTvhlu4edphy6fOQiLJQo+ynvK1iDzM0vhSbtVsAahaE9chKIhTGNvWarf6FtpLJXz
	 lV1WfyRw++kX1AlOaZZ8gUSYZKrfz5I1r7zeMriarAlsLQaFS8bwjSWCiunQdBTIo1U4u
	 zVp1/FRZh+K7+PPnVsxcTG2n4AfA7KXRb4bDcpCftAZ1Z+ma9uRh2Hso3RrVPk/2S1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nxp.com;
	spf=pass smtp.mailfrom=nxp.com;
	dkim=pass header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=PgfZmKLQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.66.0
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012000.outbound.protection.outlook.com [52.101.66.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52149606A31B;
	Fri, 23 Oct 2026 10:59:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 52149606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nxp.com header.i=@nxp.com header.a=rsa-sha256 header.s=selector1 header.b=PgfZmKLQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pC+UyFi3qnyhp4+5UiQegKkojpv/wbMYEHOKvlNcGuJ1WampNoWvra0dWSm9BeX3z9MXTYRswf/BcJJQSKDzytGD33NPaNgrCOlg6rEPhLxgvoDlodOieq5TgoLVM8LE9xLMMLcxDTu40RtgU4PBvVPVErw/8SX6iQB9vxUN6xVATD5/PNJSLstOagZuTCINstILcYa7Fzz+Jfr4NcMrdRWJBLSnvCPUtNZuu23EvUJ7Vj2dQ5ukJ/OD5tbI2MZnc26Mx4zawCJo8KkGcpaTD2O3oH07G838i0OQVSPsCiKyUQbbMEHclmEi6PrA7iwdpbXjX/eHPOh8hF13jDUx0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AZHMsf9MaFL5RcOokb0S1vsfdFBgDY+pPXwYE6SPgnY=;
 b=FMydSgHC88G3mYqvtoakxx3AaRxnpl+kCP9dGR8LH86J8tjULN1/Ka65QnhymTHqJfCtByCB1stA3FfXUo8vy4Hi+leGii6SL2JUoh9uf4BE9IhmBMFjAHhAt+LBA2itWgonBmvcr+MDy5r0PzBUMv2orH4yzENiMgf76gNqwMLcyw3q2HjmiBYNFPNxuyoqSym+EjDyT+mBvIAVpVstpNb0IK8KD+6mR2dvlPvSIBl1EQV+Hc9QIw7TFtpMKU/RWzJ27Gjb4g2aRtFQl1EbHrzsw1YW9VKmsqy9nUs0mUe6Dxipe/2UZkcm104oUtAmL5infE5L0mD1WRF7PAtcQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AZHMsf9MaFL5RcOokb0S1vsfdFBgDY+pPXwYE6SPgnY=;
 b=PgfZmKLQZQxu6ZKD9nUlc7PVOFE5ic430Se4GrG7qL6EHHI9aIug2fUpiA7Hb7jm8XcRGjg6QlOuEuJ5HJLsCAzQzedrBrJotuRTgejPF4Eq/yaVqGq7+gxYY6XJqhX2gbB1MsE+KXZqLdrtCpzqQuFMMbGG1wO8AfbtFHeEJ8lTbnkeklSEzKwKp5efqFZsc66Jpnfnb/FiLP9Slwc5S/YOr0XNDJksmDwxfwsTDVetKVBL5L1DucpY86uGwH+qZqUgJ84hgKVqS7vrMjiXStXURNYS4Dqz0uZiZlZzD75QfZw9lqRpDHypFSehcUuStRiYmrW6HQjmWOSIxhlP/A==
Received: from AS4PR04MB9362.eurprd04.prod.outlook.com (2603:10a6:20b:4e7::9)
 by VI2PR04MB10287.eurprd04.prod.outlook.com (2603:10a6:800:220::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 10:59:52 +0000
Received: from AS4PR04MB9362.eurprd04.prod.outlook.com
 ([fe80::abe7:4a6e:a51:baf0]) by AS4PR04MB9362.eurprd04.prod.outlook.com
 ([fe80::abe7:4a6e:a51:baf0%6]) with mapi id 15.21.0546.012; Fri, 23 Oct 2026
 10:59:52 +0000
From: Lakshay Piplani <lakshay.piplani@nxp.com>
To: Potin Lai <potin.lai.pt@gmail.com>, "alexandre.belloni@bootlin.com"
	<alexandre.belloni@bootlin.com>, "linux-rtc@vger.kernel.org"
	<linux-rtc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
CC: Pankit Garg <pankit.garg@nxp.com>, Vikash Bansal <vikash.bansal@nxp.com>,
	Priyanka Jain <priyanka.jain@nxp.com>, Daniel Aguirre
	<daniel.aguirre@nxp.com>, "potin.lai@quantatw.com" <potin.lai@quantatw.com>
Subject: RE: [EXT] Re: [PATCH v10 2/2] rtc: Add NXP PCF85053 driver support
Thread-Topic: [EXT] Re: [PATCH v10 2/2] rtc: Add NXP PCF85053 driver support
Thread-Index: AQHdRFOLfwNmYffoUUKaWaEiqlRUlrcGETiAgAUTwnA=
Date: Fri, 23 Oct 2026 10:59:52 +0000
Message-ID:
 <AS4PR04MB936282D6FFA724F34D7C59BBFB642@AS4PR04MB9362.eurprd04.prod.outlook.com>
References: <20260914141537.3881890-1-lakshay.piplani@nxp.com>
 <20260914141537.3881890-2-lakshay.piplani@nxp.com>
 <179247114505.1909331.8772243042180533977.b4-review@b4>
In-Reply-To: <179247114505.1909331.8772243042180533977.b4-review@b4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_Enabled=True;MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_SiteId=686ea1d3-bc2b-4c6f-a92c-d99c5c301635;MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_SetDate=2026-10-23T10:57:33.0000000Z;MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_Name=NXP
 Public;MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_ContentBits=3;MSIP_Label_f6375508-4f8d-4bf0-98ed-14865d40f2d8_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS4PR04MB9362:EE_|VI2PR04MB10287:EE_
x-ms-office365-filtering-correlation-id: 97da9494-7a42-445d-dd17-08df30f4c3cd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|366016|1800799024|23010399003|38070700021|4143699003|11063799006|56012099006|261022105027099003|261009223027099003|10067099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 wZhWgX7RSMl8QFcNMOzyia6e41AhF8eyn7ynsMrQvo/BNtaEYt2lecun7n7+i6mcsMgJVcD4alPJkxKkeE7VUpmFBfCJbScvTbALK8HDUWVGnHo9FhQYoYX3tNLnxsNNyl5spCPKIdvH/vmczLKh4ALSnwaCSJw+pi54+GmHm+zx143YtqgCevDYXA6cdvTnK1uU6ZPTp/Ed61TzYAvepuiGZzzbf7eyVd27DMcm4Iny3SSba53/JrrkteJlc3w/IPeM6QZOHWJrLnMzqMBLSk2B46O8r/Zj0kCOvgEi4gGSWmNPpChs7Ps3IdO2TCKUcR8R/I2biDfXGO+2VJ40vGJkcaXlCk46eQleQOuqp0LzZ6VeCZfdTEZ4Sv9D9/PDT2WSKX1G0gGi4JthNhk/4vFV2WzM97FaaFFWHuMD2zFCtp70MdcAzz7xeNE/9RLmrj91WQKKppF7nb8TZBg4ETWFG5V4rTtU3RaxmVPvx0FNcZYWRVgIvqq/1lusPP2FiD2Eap/bVAchy049L/LlpomY0kUiz7hxzsp6f4jc5UHKPPgGar57nMvHuiSI3lGHN3awTatIkt1tPAQayc9GnSPnoL/XIHxaqnIX6hLbOFxmq2BwPHYtdFOmK6joKIgTc3Px79hg4gr69AOGH1MbRN4dS3/y9zWLUuJzzSapK1rYloWFp2oQVuRqnoUpxko4TFXhEoX8OlNqRIRA5prS0zNjRpICov6YxTTaGXDbLeY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR04MB9362.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(1800799024)(23010399003)(38070700021)(4143699003)(11063799006)(56012099006)(261022105027099003)(261009223027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SDhxL0wyU3NlWm9SMDZUQ3VURStST3UxaXE2cUJ0dFhYUDM2U1g0TElzc1V3?=
 =?utf-8?B?YVh4L0IrNXB4VFdzdTRXUHZ3VjRUOWFKN1p4M0dGRFlXRDNaS1ZkRTJ0MHpu?=
 =?utf-8?B?cGU5M0ozVWI0dnFWbTBxbHV4c0lqcUgzemFZcFNsNE9mc1RmalZBV2EraHF6?=
 =?utf-8?B?L2tXWUwramREb0JkSWlxWnB6ZEtQbG5aMzNKNlpxemg1ait1SXpyUU1wbTJR?=
 =?utf-8?B?TXhuNmR2T1M4Wk9TN2ZRKzJ5cEdGdGJOKzVKdWJrUEVlNDE3L20zazhKUk1z?=
 =?utf-8?B?SkJwbXVtTVM2a3ZEc2V0Zm9iaXdVUUNVbHM1a2FGVU9nNWQ1ZTJlb1JUQjB5?=
 =?utf-8?B?TGc5WjJ0ZWIycHRSYTdOd2krbTZob1J1UjByV1hQZitFMzJjd05tNEJORWFw?=
 =?utf-8?B?bmxlZUZaMmYrUmhBOStKVVladDBrWUpoOHVuUlNBbVhlQWpmQnI5cTducUxV?=
 =?utf-8?B?MXdpRWFtaE5NYnUrbmlYdjJWelFna2JlWS9NU05rKzFoRFlvR1RONllqamVn?=
 =?utf-8?B?bWlHaUdhUjZva0xtdmpZVkNEMURrUm9JeE12S0lSRHRxRVlsWTlkSjR1YXVV?=
 =?utf-8?B?K3hHekpMUDl0YlM3NkM5R0tHR3l1TUpZZ2V0Q1RxUFJ4cFZPcG4zb0laUjFa?=
 =?utf-8?B?bXgwOWJGbzgyRFk2cFZHbWlYdmRGbW9Kb2c2SlNremJOZm5UWTE2RlJndjVL?=
 =?utf-8?B?c24wWm5DYkxBWE1NZmNUL2kzQk0rY0NBUXhid05xUXJYdHJwcGZkYWVLTkJa?=
 =?utf-8?B?QzNoL3dwRzVNR3ozMTZENTE0K2E5ZEYwVFBUZzk5M3B5cTZpNVJwNkhZTjlN?=
 =?utf-8?B?WlRvZWpSSDZPaFdhbzlVVThiZzMvMkovdjFMK0NJS0RCZU9HZEorZTY4MEZF?=
 =?utf-8?B?NzhyYUcyemxJcFE4QmtHVm15R1NhL0VRNGZJRUxIa3V5VHY0SFpmaXYzaEJs?=
 =?utf-8?B?WVFUR0gyUTJhM2ZSQUtDc1F2MDBRWFdaWWZSeC82UnZzK0w3bzRDYU5DQjJJ?=
 =?utf-8?B?clUwSkFaTFdFV2w3QUhZSStnS3dNNVhHVkJZVFI3SHV4ZG5xQmd6cFpkNUdv?=
 =?utf-8?B?T1BFWU1UZEFmNnhnbW1ob21iSVdVWHo3T25YK1o5OXcrOFJMMzNLQTlKU0E2?=
 =?utf-8?B?aFRRMFVOSHVncEFsdWVqeTFLVEJSc2VnVWp5ODdqNVlyLzAxZ1BPUXpXMFM4?=
 =?utf-8?B?c1ZWSExFVTNNWHJLQnZqc3Rub0I5a2RwZ2x2dGZFT2l3d3dzd1Q4OXdLWHc0?=
 =?utf-8?B?bk5HNFlqczFsQTd4Qks3ZUIzNFFqdG9rMnRFZ3VtcmFhQjFadEpUQ3VLaTVv?=
 =?utf-8?B?MlNFb1MvVlh2MFB1YnFDTVlJc1hGV1kxb042WDVyclU1QmNuLy9BdlBkQTNI?=
 =?utf-8?B?WEszTEdDT0NLcUVvVmFlbjV4c1RyTWtqelNQcWpOVkFSd1cwZCtzMS93TVpi?=
 =?utf-8?B?UjZITDBjODRJcnA2VlFUZWhWS1VNSXcwRG85RENlRFBMRHVteW1OeEZWaHhX?=
 =?utf-8?B?T0drMHdkU0h2TnFidnFoVU5ZbkpsZysyZ3daYkRnNEI5UmNETWEraU5LdmxI?=
 =?utf-8?B?RWVycXNldjlVd2FxSmRGZVN0OCtOK0tnaXR3WHRQV0tlREcxNjU0M05uOHJ3?=
 =?utf-8?B?RU5TNXFxblF5cW1SVEFDQ21hb2ZsMkV4SjE0aGJVZ1hySWVuUDFnYkloMEov?=
 =?utf-8?B?V3ZnaGN2Q3g1SmRjRFdnZkdJZ3hia0ZhVnpwb2svdXJreTNlM1RRbStKYmRa?=
 =?utf-8?B?dEVodDBkZXFOYnRNNktoZEEwT08wM2xIN2l1UGxGNG9EMENidXgrellsVm5r?=
 =?utf-8?B?UzV3RklndkVWQTkzYVFvOGNGcGpPSVRJV25yMkN3T1VjQnJXaHFNWXI0ZCs3?=
 =?utf-8?B?cGpTTTFDdDh4SHUxaEQwOFRFQ1FaZ3N3NGtVZVoyY1F5UjNXTEZEbWZTR1R3?=
 =?utf-8?B?OFZWNUZQand4NzkveU94Wno5ZWYzSmxpeGhzV1VGbzl1RWxXdjR2aHJxak1B?=
 =?utf-8?B?b2JuNm8ydHBMTm5LV1czNy9Kb2hWbko5UWVWbW9QME9Wb2FiOEc2cjBtNlA2?=
 =?utf-8?B?YjR5aEpSMmRLSjVDK3hVV2dEWFAvd0RIbGVUeG05QmRSVVFYMDRsQXhtUXN6?=
 =?utf-8?B?dWZ3cTZvazZWdGx4WGdYbzRSZFhCRitqejhUa0lCZTB6TTM0aDlYNTA2aDJy?=
 =?utf-8?B?ZlNQTmY5R3lBUUwxdVF0M2FwZkFwNldLWUIzcUZ3ekF1a2w1OUcrUEJBU3Y3?=
 =?utf-8?B?YTdWTnRKWFljcVlDU0dYbUJUWUxWR215UG9COU5jUCtsbVhwdjlMTFlYYnF1?=
 =?utf-8?B?Lysycll1ZWJjbW1rZmFDZGx3eWE5dmQrUjIyNnZVbjdrcUVGVmlPdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS4PR04MB9362.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97da9494-7a42-445d-dd17-08df30f4c3cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2026 10:59:52.4598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: c7ZtGPtQOzl6Yj7m6WMf9o9y2A3eWycJALWgqRkbNIHlslj5TZGNhkluhnTnBqBD/fKnrOuFGEwg1jG9SebZGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10287

DQpOWFAgUHVibGljDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFBvdGlu
IExhaSA8cG90aW4ubGFpLnB0QGdtYWlsLmNvbT4NCj4gU2VudDogVHVlc2RheSwgT2N0b2JlciAy
MCwgMjAyNiAxMDowOSBBTQ0KPiBUbzogYWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb207IGxp
bnV4LXJ0Y0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyByb2JoQGtlcm5lbC5vcmc7IGtyemsrZHRAa2VybmVsLm9yZzsNCj4gY29ub3IrZHRAa2VybmVs
Lm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IFBhbmtpdCBHYXJnIDxwYW5r
aXQuZ2FyZ0BueHAuY29tPjsgVmlrYXNoIEJhbnNhbA0KPiA8dmlrYXNoLmJhbnNhbEBueHAuY29t
PjsgUHJpeWFua2EgSmFpbiA8cHJpeWFua2EuamFpbkBueHAuY29tPjsgTGFrc2hheQ0KPiBQaXBs
YW5pIDxsYWtzaGF5LnBpcGxhbmlAbnhwLmNvbT47IERhbmllbCBBZ3VpcnJlDQo+IDxkYW5pZWwu
YWd1aXJyZUBueHAuY29tPjsgcG90aW4ubGFpQHF1YW50YXR3LmNvbQ0KPiBTdWJqZWN0OiBbRVhU
XSBSZTogW1BBVENIIHYxMCAyLzJdIHJ0YzogQWRkIE5YUCBQQ0Y4NTA1MyBkcml2ZXIgc3VwcG9y
dA0KPg0KPiBbWW91IGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIHBvdGluLmxhaS5wdEBnbWFp
bC5jb20uIExlYXJuIHdoeSB0aGlzIGlzDQo+IGltcG9ydGFudCBhdCBodHRwczovL2FrYS5tcy9M
ZWFybkFib3V0U2VuZGVySWRlbnRpZmljYXRpb24gXQ0KPg0KPiBDYXV0aW9uOiBUaGlzIGlzIGFu
IGV4dGVybmFsIGVtYWlsLiBQbGVhc2UgdGFrZSBjYXJlIHdoZW4gY2xpY2tpbmcgbGlua3Mgb3IN
Cj4gb3BlbmluZyBhdHRhY2htZW50cy4gV2hlbiBpbiBkb3VidCwgcmVwb3J0IHRoZSBtZXNzYWdl
IHVzaW5nIHRoZSAnUmVwb3J0DQo+IHRoaXMgZW1haWwnIGJ1dHRvbg0KPg0KPg0KPiBPbiBNb24s
IDE0IFNlcCAyMDI2IDE5OjQ1OjM3ICswNTMwLCBMYWtzaGF5IFBpcGxhbmkNCj4gPGxha3NoYXku
cGlwbGFuaUBueHAuY29tPiB3cm90ZToNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ydGMvcnRj
LXBjZjg1MDUzLmMgYi9kcml2ZXJzL3J0Yy9ydGMtcGNmODUwNTMuYw0KPiA+IG5ldyBmaWxlIG1v
ZGUgMTAwNjQ0IGluZGV4IDAwMDAwMDAwMDAwMC4uMmViOTRiMWRhM2VkDQo+ID4gLS0tIC9kZXYv
bnVsbA0KPiA+ICsrKyBiL2RyaXZlcnMvcnRjL3J0Yy1wY2Y4NTA1My5jDQo+ID4gQEAgLTAsMCAr
MSw5MDAgQEANCj4gPiBbIC4uLiBza2lwIDc3MCBsaW5lcyAuLi4gXQ0KPiA+ICsNCj4gPiArICAg
ICBkZXZfc2V0X2RydmRhdGEoZGV2LCBwY2Y4NTA1Myk7DQo+ID4gKw0KPiA+ICsgICAgIGlmIChv
Zl9wcm9wZXJ0eV9yZWFkX3N0cmluZyhkZXYtPm9mX25vZGUsICJueHAsaW50ZXJmYWNlIiwgJmlm
YWNlKSkNCj4gPiArICAgICAgICAgICAgIHJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgLUVJTlZB
TCwNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJNaXNzaW5nIG1hbmRh
dG9yeSBwcm9wZXJ0eToNCj4gPiArIG54cCxpbnRlcmZhY2VcbiIpOw0KPg0KPiBIaSBMYWtzaGF5
LA0KPg0KPiBXb3VsZCBpdCBiZSBwb3NzaWJsZSB0byBwcm92aWRlIGEgZmFsbGJhY2sgZGVmYXVs
dCB0cnVlIGZvciBgcGNmODUwNTMtDQo+ID5pc19wcmltYXJ5YCBpZiB0aGUgcHJvcGVydHkgaXMg
b21pdHRlZD8NCj4NCj4gSW4gdGhlIGN1cnJlbnQgaW1wbGVtZW50YXRpb24sIG54cCxpbnRlcmZh
Y2UgaXMgc3RyaWN0bHkgbWFuZGF0b3J5Lg0KPiBIb3dldmVyLCB3aGVuIHVzZXJzIGluc3RhbnRp
YXRlIHRoZSBkZXZpY2UgdmlhIHRoZSBzeXNmcyBuZXdfZGV2aWNlIGludGVyZmFjZQ0KPiAoZS5n
LiwgZWNobyBwY2Y4NTA1M2EgMHg2ZiA+IC9zeXMvYnVzL2kyYy9kZXZpY2VzL2kyYy1YL25ld19k
ZXZpY2UpLA0KPiB0aGVyZSBpcyBubyB3YXkgdG8gcGFzcyBEZXZpY2UgVHJlZSBwcm9wZXJ0aWVz
LiBCZWNhdXNlIG9mIHRoaXMsIHByb2JlIHdpbGwNCj4gYWx3YXlzIGZhaWwgd2l0aCAtRUlOVkFM
Lg0KPg0KPiBUaGFua3MsDQo+IFBvdGluDQo+DQo+IC0tDQo+IFBvdGluIExhaSA8cG90aW4ubGFp
LnB0QGdtYWlsLmNvbT4NCg0KSGkgUG90aW4sDQoNClllcywgdGhhdCBtYWtlcyBzZW5zZS4gSSB3
aWxsIG1ha2UgbnhwLGludGVyZmFjZSBvcHRpb25hbCBhbmQgZGVmYXVsdCBwY2Y4NTA1My0+aXNf
cHJpbWFyeSB0byB0cnVlIHdoZW4gdGhlIHByb3BlcnR5IGlzIGFic2VudC4gRXhwbGljaXQgInBy
aW1hcnkiIGFuZCAic2Vjb25kYXJ5IiB2YWx1ZXMgd2lsbCBjb250aW51ZSB0byBiZSB2YWxpZGF0
ZWQuIEkgd2lsbCB1cGRhdGUgdGhlIERUIGJpbmRpbmcgYWNjb3JkaW5nbHkuDQoNClRoYW5rcywN
Ckxha3NoYXkNCg==
