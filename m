Received: from PNZPR01CU001.outbound.protection.outlook.com (mail-centralindiaazon11021103.outbound.protection.outlook.com [40.107.51.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FF52F6577;
	Wed, 26 Aug 2026 06:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.51.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787726275; cv=fail; b=jJkgZjoSlNjLGrGZNdQmAdp8ckU6Avuq4Ke3QEtDTcKlHMC0sUTd5KZf1nJ3m+0vDhtxy5Hia8AmzeHrlPE+GQlPSf8f5oU64oNsgBAmxSHFIAe8A2zDIwM88DrGQES+Np12iy0j7pYOkGIS6PIcZX/ZY0yugd2QFrul3fbhv5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787726275; c=relaxed/simple;
	bh=Xl0qL2hAj3U5pN7Tr11/5Y/+PTt8yHzYSI52ukjqkY0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LqkbVTr3mzJm/+/5eHA/PJr3n+vfKxWzKf/MMMNGhJvUw3nD9LvdNc/7a3lw/6H3cw75gZE8DwT6zlM6cP2Q7kQNLMrvwR3XiQGLekm8+Uf/YJsH4jvDlXtHvrqxk1URTnG8NpJrwMkRAUc8naDl6FO1JqJKrdGz8WpWKO3RYY8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siliconsignals.io; spf=pass smtp.mailfrom=siliconsignals.io; dkim=fail (0-bit key) header.d=siliconsignals.io header.i=@siliconsignals.io header.b=NoaQUgpg reason="key not found in DNS"; arc=fail smtp.client-ip=40.107.51.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siliconsignals.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=siliconsignals.io header.i=@siliconsignals.io header.b="NoaQUgpg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q19oBXw85FcjqGIwQkQvdK0wbPjuFTYd5Q0dbWGxjwsFTa05FKgNITPW7U2qMLcz2wb9rkIFdSK7LCtwhRipAlUn21Rw4wyAnThfV4n/5n/yQ9SjcCAL2qfhuGWpExEBojypAd0B6C4gQ/B3pkevG7qH1055cgBmaegk0Rmnxn0jTz3YNp69e9Qb7vaWA/kESVeTOnvPdFPhymdOy5ZJwIh5Ag0wJ/ZOWbnG0oBrrnHGcD7h9Ntgh5fE0BAvT84g5M9Rc4vK34o/IdU14KRVdGqHeGWjF3l0YuUwYdRnVrZFOw/mMCAYFyZL5UDCp1wMFJcRbnjY83xvzRVnd0pvHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxhJ1ewa6W/6rRpZ1szWgD9kb/NJ9sE34j2qu1mJQcQ=;
 b=dEqEfYCcFCeiH0KxiKg1jCrPkDQdBcviI9EFfQV+Cqm13Q/daz3KOV58sKWTZxICfSIOSUNCAaP44SQRVgwnjk+yLcfJo0Xo+6bPkMyF0P2Un/bDosURhO8wv1vwwoOqfIXM9otiFmhHnYKhbAkeL0gLRfvZxK3XeFKQsBBIoPXjv3SZHRQFVV2XxKx5JgGolh4H4jHQxl8pUsxDH/lxOhAIzh0siC/B2+1OkPagptp7qCq5fR3UYxM5uiiqw8iKYFzXhAzM3CYJB0/GOI2apjuBx/VEyFjhlHbEDK47eDr+K327eSu3tgnxhf/0n+vK9ASI10fMrImmrEE3BbqbCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siliconsignals.io; dmarc=pass action=none
 header.from=siliconsignals.io; dkim=pass header.d=siliconsignals.io; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siliconsignals.io;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxhJ1ewa6W/6rRpZ1szWgD9kb/NJ9sE34j2qu1mJQcQ=;
 b=NoaQUgpgSeRewPhmE5mXf8cgAoK1IfcAgQ9y1bgJzEHJUQ2mYzPsBbQDsIRSsakGxnevz4fINTCfQlERnfARBNfXO5TiicPVzReg4yLQXd0p3AZN3UW0TVbROcMpiw0GyCKfPkaGbsvIGQxnoj/60wxFe64LNRdNgNqxM65SugSviSQ4kBF9wGAM2mCeIsf3qoZwRpwgJ0kQmXrqVBeOY8Uceibh/xQtzBMg4kwDjzCiW2sXXzKCKjRVgGF92Wwqpt0lU0n8xmevaJ1ZtJyBeSfFGecNO9PBrBI3bmdvqUavnrPAblJaTmWZM4V83p4mbfFh+t8eDg8lIqF6uL9bTg==
Received: from PN2P287MB2892.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:237::12)
 by MA5P287MB4824.INDP287.PROD.OUTLOOK.COM (2603:1096:a01:180::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Wed, 26 Aug
 2026 06:37:48 +0000
Received: from PN2P287MB2892.INDP287.PROD.OUTLOOK.COM
 ([fe80::8964:b393:996e:e8c2]) by PN2P287MB2892.INDP287.PROD.OUTLOOK.COM
 ([fe80::8964:b393:996e:e8c2%3]) with mapi id 15.21.0360.006; Wed, 26 Aug 2026
 06:37:48 +0000
From: Dhaval Shiroya <dhaval.shiroya@siliconsignals.io>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rtc: rv3028: configure backup switch mode from device
 tree
Thread-Topic: [PATCH] rtc: rv3028: configure backup switch mode from device
 tree
Thread-Index: AQHdMhjAgsJCqT4WDEeVT1JmMb/iuLaqCrsAgAXbgJg=
Date: Wed, 26 Aug 2026 06:37:48 +0000
Message-ID:
 <PN2P287MB289211E7C870D80EC2F7603F8DAE2@PN2P287MB2892.INDP287.PROD.OUTLOOK.COM>
References: <20260822092911.318342-1-dhaval.shiroya@siliconsignals.io>
 <2026082213092838377a26@mail.local>
In-Reply-To: <2026082213092838377a26@mail.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siliconsignals.io;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN2P287MB2892:EE_|MA5P287MB4824:EE_
x-ms-office365-filtering-correlation-id: 7ccf5b4a-72dd-4826-747f-08df033c8b84
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|376014|366016|38070700021|10067099003|4143699003|56012099006|22082099003|18002099003;
x-microsoft-antispam-message-info:
 Q4ePSnMVUQaIi+8ctYPrIINBSM2Ywdyuc2q0TckWHBD5bfYm3O7egFFBwiMqKng0ERKA4JnStGl0XBnyD1gf1p73JNEfTW0j0hDX7TSv46FyDhhb/PUMemB5eJXiGImPU4S8P6JUYi9pBu7BG9re1SBgYK2MdH9Zuq6v30zY9mSdO/1GIfcNycXYS/rhBH3SBnvoAVnN3Xio1DVVQUOfsXIt6qxLGLzV/m55x9npHk95WU7r63H7GtHQXTcUpgErdrmiWrlULnxEuSDFxLGQ6lgA39wXusNW2+x2xwPg+FfF2JwnwBwa23cNasiAZoH0RCYUP2nVzY8ho16ZOPpbPyJ2KyA08w+BdFjMeR8bxZLLwoYuLM5aBNIP6nw/h0T35muNKnTqU8gXfyeMepc/gVvcD0FcDb04tJYBSzKN54dR7U0cLTPEX+BhnvNwSG85P+ommcDpNDdFrF2iGNnxe9j9Itlm3lwNDjCf3rAAvig6D/vpT+kNGl/9UI0eCOHgyeYXRG6Gf4nhIXsT9NGlyEeBboy9ranIlWX6nRQCrUH7Z5MTLhKk0HKCu9W8qvUZVtCzK152tQFxVFIJ4yIzePS+vSGAhfYPo0nZRvmOaaHTonBQN4b3T7TwfcwhJ3oP2xyo93huj7XxH5aeCKkMjgBCtt3UyPwzgYIY5r9il8Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN2P287MB2892.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(38070700021)(10067099003)(4143699003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?1+s0jnNlY97T2QhzeoyYy4Ve8AKRO6jY3GG+/WauuZALbcLu4CcqZdQ5L/?=
 =?iso-8859-1?Q?Srp+6hfSCa1JQIp3NblY0Uby4vCIZ+2890utUieZFrDoUpoNqA8IdLSSlW?=
 =?iso-8859-1?Q?j6GmkflF5IuiW7apTc5k3Lpns6vW+FFuIpXsInuH9d9C85iTDWjsgfD6Ao?=
 =?iso-8859-1?Q?F66C9RCh9F7Lzz041Etwyue87vra7njcwEnLd0pQ7nZ5teP5QvPoDYIIIG?=
 =?iso-8859-1?Q?3c8bJroDIihi24cX8Ws4eK6+cQosLUGa4rGTEhXfQUXDj/Nl3gp8DHcnhF?=
 =?iso-8859-1?Q?CMeSkrcvHzGWpvI8r2msf6JCn5ZBgwhgz5wO7C33+lXrZGsWT7JrfG8gWV?=
 =?iso-8859-1?Q?I1A7ZI6dgSfFWzRTGpYwVC7Bkhp929xywUxpJSzvwH0sUVTXzZt0Vsff43?=
 =?iso-8859-1?Q?y5O6gVEMtz/rl1DOOXnk3LM/BSDlCBMAgOqFAAz1g0KwXmGzDHtDbjpJn8?=
 =?iso-8859-1?Q?gN5GhZ0grjlzZLR8BUeSoXEldfONDtg1FkYQH/SSk75QsUaHS45H29VPT7?=
 =?iso-8859-1?Q?79GZyTtBYV4qetANkoTcP6ya9uKphqIxoJ85igwpPlsWfrRiDrXQ2H3iun?=
 =?iso-8859-1?Q?ehCo+MvAb7wmqqgi1wpKRrlQkk6AFOsbRS/9D3hAmZAdzIJzhKF3Jek96e?=
 =?iso-8859-1?Q?+/v83ygQellRmCMJI25dWnpXrg+Z0PfZYZsdF+cG+iOHCDvZZ6UxWGN66b?=
 =?iso-8859-1?Q?qkZyaMoBcwqbE7pe0lx397Ki4DHsUnhjhxSuKC99kXXXmxc5JlQei9jDMy?=
 =?iso-8859-1?Q?TVltqb2Qpp+Vw17olqZ4gPyJxfzEFtGywfcU8evj8btcavYx3orvNhiEA/?=
 =?iso-8859-1?Q?+EhZQFkqECj7txP3B7n9urNKRYJTank9HDgaNZiDI7ETnPIzPp6x9oTdQ7?=
 =?iso-8859-1?Q?Ba3cqCmbYjOZwENV/Of7R70Mer03yoh3CvsVKoSha5fNja0EESNbCwUuE8?=
 =?iso-8859-1?Q?QwZCppoEdTWdC9c5czsR2l7YPqW748xeYjo2IqCnmUaowJO8dA8Sdw4tVX?=
 =?iso-8859-1?Q?z+ELTtm3T3aKtuQp+00rWF16l7bl+o591r4IpH20GQg4dfOaoarVDFnifN?=
 =?iso-8859-1?Q?lDRqIy8vAHMnLHWvKyC4/fvhdfQ2KMX34QjHuaJ+GOBDGBsOJxQMRrbqKG?=
 =?iso-8859-1?Q?oyLQ49Es44BdMIbzHX1EQkkd/Ssu97extKNqrk5vy4tqXYZ7UfXbLA4vgb?=
 =?iso-8859-1?Q?pXKSwpRh01APensXC6PFchl10A0vwOz2AqoBYGyprDfgqzKgshi82wMTFK?=
 =?iso-8859-1?Q?IBT6z8uARrSiQu4G3G+RJjO4Iw+5sl1jW7yKpZ6h9HamDNrbrvMKdn8mwR?=
 =?iso-8859-1?Q?u/czWlyp4NpJMo9OfrWqOkHJamsaA1z+0SW1L54UaPVAD8RHMNYeWJc7Au?=
 =?iso-8859-1?Q?x8IilG6pEl5uaqWlhDfBF4JebOCOfAxb5q0eFkplHHiH/sUXDQ1JS83WB9?=
 =?iso-8859-1?Q?U+0Lb4qP7cFemkHCIdVMnLRmHdCLNzUTSzsTZ0mA9biwRHiCQf6pGBNNrI?=
 =?iso-8859-1?Q?wkNzr92+OT4YGUdyUj+H6oxllfSxxkA+LGmMxGGmrj/X/8gEiqn+chjnQ2?=
 =?iso-8859-1?Q?YzoRssptcUHEpshhfY6Y0j9FUS64hVM79D0zcKIOMI83rY5hlEv083i0oT?=
 =?iso-8859-1?Q?9MuZA7QveoVXz9kQvxGAdgSCba5XrUeqUl5DjLELIIVhgPdlY/4eeWZeld?=
 =?iso-8859-1?Q?Xz1Sx60NJXBSEuG24WCHew68CHH/+ATjr66isNyUkMFDdgATyNkHOgZmdi?=
 =?iso-8859-1?Q?mvho6JFb+rlHoRK6dLYMvw7b3pXwxwt15lFcYB0tUsFt+NOMaAj9T+aT7i?=
 =?iso-8859-1?Q?B2zKcovYH7ccSkWucS4gF0E6hBaznlE=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siliconsignals.io
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN2P287MB2892.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ccf5b4a-72dd-4826-747f-08df033c8b84
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2026 06:37:48.3139
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7ec5089e-a433-4bd1-a638-82ee62e21d37
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ierafwG4KH418DnwIw3sWC2cquYHGVP91hofSuHCl253KUO3/YHKksBsUiJFN1Hiiavh6llgu0KiLhrPxl1OFcFR8mUk7oqtmbWvM2lIg4W0KKyybr16jykOlAcM8Hg3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MA5P287MB4824

Hi Alexandre,=0A=
=0A=
>On 22/08/2026 14:59:11+0530, Dhaval Shiroya wrote:=0A=
>> Enable and set the backup switch mode directly from the device tree at=
=0A=
>> probe, instead of requiring a userspace RTC_PARAM_BACKUP_SWITCH_MODE=0A=
>> ioctl on every unit.=0A=
>> =0A=
>=0A=
>No, just use the ioctl.=0A=
=0A=
Thanks for the reply.=0A=
=0A=
Instead, can we enable the FEDE bit, as the datasheet recommends enabling i=
t when switching to RTC Backup Switchover Mode?=0A=
=0A=
Could you please share your thoughts on this?=0A=
=0A=
>=0A=
>> Signed-off-by: Dhaval Shiroya <dhaval.shiroya@siliconsignals.io>=0A=
>> =0A=
>> diff --git a/drivers/rtc/rtc-rv3028.c b/drivers/rtc/rtc-rv3028.c=0A=
>> index d96f6bb68850..5dde1aed76dd 100644=0A=
>> --- a/drivers/rtc/rtc-rv3028.c=0A=
>> +++ b/drivers/rtc/rtc-rv3028.c=0A=
>> @@ -80,6 +80,7 @@=0A=
>>  #define RV3028_EEBUSY_TIMEOUT		100000=0A=
>>  =0A=
>>  #define RV3028_BACKUP_TCE		BIT(5)=0A=
>> +#define RV3028_BACKUP_FEDE		BIT(4)=0A=
>>  #define RV3028_BACKUP_TCR_MASK		GENMASK(1,0)=0A=
>>  #define RV3028_BACKUP_BSM		GENMASK(3,2)=0A=
>>  =0A=
>> @@ -519,70 +520,6 @@ static int rv3028_set_offset(struct device *dev, lo=
ng offset)=0A=
>>  =0A=
>>  }=0A=
>>  =0A=
>> -static int rv3028_param_get(struct device *dev, struct rtc_param *param=
)=0A=
>> -{=0A=
>> -	struct rv3028_data *rv3028 =3D dev_get_drvdata(dev);=0A=
>> -	int ret;=0A=
>> -	u32 value;=0A=
>> -=0A=
>> -	switch(param->param) {=0A=
>> -	case RTC_PARAM_BACKUP_SWITCH_MODE:=0A=
>> -		ret =3D regmap_read(rv3028->regmap, RV3028_BACKUP, &value);=0A=
>> -		if (ret < 0)=0A=
>> -			return ret;=0A=
>> -=0A=
>> -		value =3D FIELD_GET(RV3028_BACKUP_BSM, value);=0A=
>> -=0A=
>> -		switch(value) {=0A=
>> -		case RV3028_BACKUP_BSM_DSM:=0A=
>> -			param->uvalue =3D RTC_BSM_DIRECT;=0A=
>> -			break;=0A=
>> -		case RV3028_BACKUP_BSM_LSM:=0A=
>> -			param->uvalue =3D RTC_BSM_LEVEL;=0A=
>> -			break;=0A=
>> -		default:=0A=
>> -			param->uvalue =3D RTC_BSM_DISABLED;=0A=
>> -		}=0A=
>> -		break;=0A=
>> -=0A=
>> -	default:=0A=
>> -		return -EINVAL;=0A=
>> -	}=0A=
>> -=0A=
>> -	return 0;=0A=
>> -}=0A=
>> -=0A=
>> -static int rv3028_param_set(struct device *dev, struct rtc_param *param=
)=0A=
>> -{=0A=
>> -	struct rv3028_data *rv3028 =3D dev_get_drvdata(dev);=0A=
>> -	u8 mode;=0A=
>> -=0A=
>> -	switch(param->param) {=0A=
>> -	case RTC_PARAM_BACKUP_SWITCH_MODE:=0A=
>> -		switch (param->uvalue) {=0A=
>> -		case RTC_BSM_DISABLED:=0A=
>> -			mode =3D 0;=0A=
>> -			break;=0A=
>> -		case RTC_BSM_DIRECT:=0A=
>> -			mode =3D RV3028_BACKUP_BSM_DSM;=0A=
>> -			break;=0A=
>> -		case RTC_BSM_LEVEL:=0A=
>> -			mode =3D RV3028_BACKUP_BSM_LSM;=0A=
>> -			break;=0A=
>> -		default:=0A=
>> -			return -EINVAL;=0A=
>> -		}=0A=
>> -=0A=
>> -		return rv3028_update_cfg(rv3028, RV3028_BACKUP, RV3028_BACKUP_BSM,=0A=
>> -					 FIELD_PREP(RV3028_BACKUP_BSM, mode));=0A=
>> -=0A=
>> -	default:=0A=
>> -		return -EINVAL;=0A=
>> -	}=0A=
>> -=0A=
>> -	return 0;=0A=
>> -}=0A=
>> -=0A=
>>  static int rv3028_ioctl(struct device *dev, unsigned int cmd, unsigned =
long arg)=0A=
>>  {=0A=
>>  	struct rv3028_data *rv3028 =3D dev_get_drvdata(dev);=0A=
>> @@ -852,8 +789,6 @@ static const struct rtc_class_ops rv3028_rtc_ops =3D=
 {=0A=
>>  	.read_offset =3D rv3028_read_offset,=0A=
>>  	.set_offset =3D rv3028_set_offset,=0A=
>>  	.ioctl =3D rv3028_ioctl,=0A=
>> -	.param_get =3D rv3028_param_get,=0A=
>> -	.param_set =3D rv3028_param_set,=0A=
>>  };=0A=
>>  =0A=
>>  static const struct regmap_config regmap_config =3D {=0A=
>> @@ -920,6 +855,65 @@ static u8 rv3028_set_trickle_charger(struct rv3028_=
data *rv3028,=0A=
>>  	return ret;=0A=
>>  }=0A=
>>  =0A=
>> +/*=0A=
>> + * Configure backup switchover mode from device tree.=0A=
>> + *   0 =3D disabled=0A=
>> + *   1 =3D DSM (Direct Switching Mode)  - switch when VDD < VBACKUP=0A=
>> + *   3 =3D LSM (Level Switching Mode)   - switch when VDD < 2.0V=0A=
>> + */=0A=
>> +static int rv3028_set_bsm_from_dt(struct rv3028_data *rv3028,=0A=
>> +				  struct i2c_client *client)=0A=
>> +{=0A=
>> +	u32 val_old, bsm_dt, bsm_bits;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	if (device_property_read_u32(&client->dev, "backup-switch-mode",=0A=
>> +				     &bsm_dt))=0A=
>> +		return 0;=0A=
>> +=0A=
>> +	/* Validate and convert DT value to register bits */=0A=
>> +	switch (bsm_dt) {=0A=
>> +	case 0:=0A=
>> +		bsm_bits =3D 0;=0A=
>> +		break;=0A=
>> +	case 1:=0A=
>> +		bsm_bits =3D FIELD_PREP(RV3028_BACKUP_BSM, RV3028_BACKUP_BSM_DSM);=0A=
>> +		break;=0A=
>> +	case 3:=0A=
>> +		bsm_bits =3D FIELD_PREP(RV3028_BACKUP_BSM, RV3028_BACKUP_BSM_LSM);=0A=
>> +		break;=0A=
>> +	default:=0A=
>> +		dev_warn(&client->dev,=0A=
>> +			 "invalid backup-switch-mode %u (use 0, 1, or 3)\n",=0A=
>> +			 bsm_dt);=0A=
>> +		return 0;=0A=
>> +	}=0A=
>> +=0A=
>> +	/* Read current BACKUP register */=0A=
>> +	ret =3D regmap_read(rv3028->regmap, RV3028_BACKUP, &val_old);=0A=
>> +	if (ret < 0)=0A=
>> +		return ret;=0A=
>> +=0A=
>> +	/* Check if BSM and FEDE already match desired values */=0A=
>> +	if ((val_old & (RV3028_BACKUP_BSM | RV3028_BACKUP_FEDE)) =3D=3D=0A=
>> +	    (bsm_bits | RV3028_BACKUP_FEDE)) {=0A=
>> +		dev_dbg(&client->dev,=0A=
>> +			"backup switch mode already set to %u\n", bsm_dt);=0A=
>> +		return 0;=0A=
>> +	}=0A=
>> +=0A=
>> +	dev_info(&client->dev,=0A=
>> +		 "setting backup switch mode to %u (reg 0x37: 0x%02x -> 0x%02x)\n",=
=0A=
>> +		 bsm_dt, val_old,=0A=
>> +		 (val_old & ~(RV3028_BACKUP_BSM | RV3028_BACKUP_FEDE)) |=0A=
>> +		 bsm_bits | RV3028_BACKUP_FEDE);=0A=
>> +=0A=
>> +	/* Set BSM and always enable FEDE as recommended by datasheet */=0A=
>> +	return rv3028_update_cfg(rv3028, RV3028_BACKUP,=0A=
>> +				 RV3028_BACKUP_BSM | RV3028_BACKUP_FEDE,=0A=
>> +				 bsm_bits | RV3028_BACKUP_FEDE);=0A=
>> +}=0A=
>> +=0A=
>>  static int rv3028_probe(struct i2c_client *client)=0A=
>>  {=0A=
>>  	struct rv3028_data *rv3028;=0A=
>> @@ -1005,11 +999,14 @@ static int rv3028_probe(struct i2c_client *client=
)=0A=
>>  	if (ret)=0A=
>>  		return ret;=0A=
>>  =0A=
>> -	ret =3D rtc_add_group(rv3028->rtc, &rv3028_attr_group);=0A=
>> +	/* Configure backup switchover mode from device tree */=0A=
>> +	ret =3D rv3028_set_bsm_from_dt(rv3028, client);=0A=
>>  	if (ret)=0A=
>>  		return ret;=0A=
>>  =0A=
>> -	set_bit(RTC_FEATURE_BACKUP_SWITCH_MODE, rv3028->rtc->features);=0A=
>> +	ret =3D rtc_add_group(rv3028->rtc, &rv3028_attr_group);=0A=
>> +	if (ret)=0A=
>> +		return ret;=0A=
>>  =0A=
>>  	rv3028->rtc->range_min =3D RTC_TIMESTAMP_BEGIN_2000;=0A=
>>  	rv3028->rtc->range_max =3D RTC_TIMESTAMP_END_2099;=0A=
>> -- =0A=
>> 2.34.1=0A=
>> =0A=
>=0A=
>-- =0A=
>Alexandre Belloni, co-owner and COO, Bootlin=0A=
>Embedded Linux and Kernel engineering=0A=
>https://bootlin.com=0A=
=0A=
Best Regards,=0A=
Dhaval Shiroya=0A=
