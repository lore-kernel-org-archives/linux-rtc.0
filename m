Return-Path: <SRS0=6w/U=QT=vger.kernel.org=linux-rtc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26ABDC282CE
	for <linux-rtc@archiver.kernel.org>; Tue, 12 Feb 2019 02:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEB62206BB
	for <linux-rtc@archiver.kernel.org>; Tue, 12 Feb 2019 02:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=impinj.com header.i=@impinj.com header.b="SQrdKYqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfBLCeQ (ORCPT <rfc822;linux-rtc@archiver.kernel.org>);
        Mon, 11 Feb 2019 21:34:16 -0500
Received: from mail-eopbgr680127.outbound.protection.outlook.com ([40.107.68.127]:17120
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727265AbfBLCeQ (ORCPT <rfc822;linux-rtc@vger.kernel.org>);
        Mon, 11 Feb 2019 21:34:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=impinj.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J8LFiNkX0U/XnOi3qGo3BShAspHFVqPZTuX+fAEYujw=;
 b=SQrdKYqVwbGG8BBXqU9AszyKm0dyUSkQj5y7wDpi8U2X2mS46bDvx3pqSDdlWQ9Rqyj0/4UNT8gidr7abfqpl+A98ESbWAbTaC5ugdX7nqRm/ztQyosDVaFYn9MeQLnYg4Yfy/EsaMvJbrlSCkJtYokxqz+3GDXiJF7kgNwynbU=
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com (10.167.236.38) by
 MWHPR0601MB3659.namprd06.prod.outlook.com (10.167.236.25) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.21; Tue, 12 Feb 2019 02:34:06 +0000
Received: from MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85]) by MWHPR0601MB3708.namprd06.prod.outlook.com
 ([fe80::ac0c:a03e:77c7:fa85%5]) with mapi id 15.20.1601.023; Tue, 12 Feb 2019
 02:34:05 +0000
From:   Trent Piepho <tpiepho@impinj.com>
To:     "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
CC:     Trent Piepho <tpiepho@impinj.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH v3 4/4] dt-bindings: rtc: Update for new chip in isl1208
 series
Thread-Topic: [PATCH v3 4/4] dt-bindings: rtc: Update for new chip in isl1208
 series
Thread-Index: AQHUwntsBuiUcMEfN0WYyQ0U2/vr3w==
Date:   Tue, 12 Feb 2019 02:34:05 +0000
Message-ID: <20190212023225.2710-4-tpiepho@impinj.com>
References: <20190212023225.2710-1-tpiepho@impinj.com>
In-Reply-To: <20190212023225.2710-1-tpiepho@impinj.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BYAPR01CA0055.prod.exchangelabs.com (2603:10b6:a03:94::32)
 To MWHPR0601MB3708.namprd06.prod.outlook.com (2603:10b6:301:7c::38)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=tpiepho@impinj.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.14.4
x-originating-ip: [216.207.205.253]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31d4f93b-b01a-4a90-4878-08d690928ed0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(2017052603328)(7153060)(7193020);SRVR:MWHPR0601MB3659;
x-ms-traffictypediagnostic: MWHPR0601MB3659:
x-microsoft-exchange-diagnostics: 1;MWHPR0601MB3659;20:wvzJV3bQDfw/6KZj09LF9S6Te9qr7K7RZcjosQmhVpLuOtO07XHfJjFPwiXXVRjs03wfR7+E/3AeXIZQI+DQmbZPhSBzQJcUPdq1iBwQbUmkZC7QgNFaSWa4xvG1fdfvyCp/RWp+wYQyyadbRHqT3jFcYeRU/6EiUyNz7FUvBuc=
x-microsoft-antispam-prvs: <MWHPR0601MB3659AE7E3E094CC113B2CD92D3650@MWHPR0601MB3659.namprd06.prod.outlook.com>
x-forefront-prvs: 0946DC87A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39850400004)(396003)(376002)(136003)(366004)(189003)(199004)(316002)(102836004)(66066001)(6486002)(25786009)(86362001)(6116002)(53936002)(1076003)(2351001)(26005)(386003)(6506007)(5640700003)(7736002)(3846002)(305945005)(106356001)(97736004)(50226002)(6512007)(6436002)(105586002)(4326008)(11346002)(446003)(52116002)(14454004)(8676002)(2501003)(2906002)(476003)(2616005)(256004)(6916009)(99286004)(71200400001)(36756003)(54906003)(68736007)(81156014)(478600001)(8936002)(76176011)(14444005)(486006)(186003)(71190400001)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:MWHPR0601MB3659;H:MWHPR0601MB3708.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: impinj.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: zlJchX8EGYq+cOhv6l10cM9QgmoFS4N3UaE+EEI/iOc67eaRB2SnipKK+pG9VupLQC9pi1eOn50x8b/QQ0Xvb8DtHJ/yGAAdwNclS8KYU71hIx7k5/FPogZeRSyQ6wPa5VM4U1Qr9TZeAjsqnG9SRk+UZ6Z65i84qoiTMIDD9EPWk5SUih9rFCzQwIP/H/nqisfZTEBZtBTB8jEkrivYCLBYj8V1kgxDDusL3YZ9GFh8Y63uR0BrTulCkR8v0+MJ7E+5JKbu97sSV5d+2jm1paawe9S4DFb+vFpLSjQi/WeAVX33b/xmSQN/cActjVeWL0gJZbJILVaz4tPmjqwY1G8bJ0SOAj7T6+ga6X1eTIQbBwGp/+H/Aue/mwDxMNbFzzeFdcRdb0RPBdxIdJhSad4f6YyATQDfOUKjQBlvEVY=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: impinj.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31d4f93b-b01a-4a90-4878-08d690928ed0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2019 02:34:05.1250
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: 6de70f0f-7357-4529-a415-d8cbb7e93e5e
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0601MB3659
Sender: linux-rtc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rtc.vger.kernel.org>
X-Mailing-List: linux-rtc@vger.kernel.org

Since this documents multiple chips controlled by the isl1208 driver,
name it isil,isl1208.txt, as the convention is to use the base driver
name in the bindings document for drivers with multiple devices.

Include all chips supported by this driver in the docs.  Make it
clear which properties apply to which chips.

Expand documentation for existing isil,evienb property to explain
operation in more detail.  Existing docs just describe it in terms of
setting a bit in a register.

CC: Alessandro Zummo <a.zummo@towertech.it>
CC: Alexandre Belloni <alexandre.belloni@bootlin.com>
CC: Rob Herring <robh+dt@kernel.org>
CC: Mark Rutland <mark.rutland@arm.com>
CC: devicetree@vger.kernel.org
Signed-off-by: Trent Piepho <tpiepho@impinj.com>
---
 .../devicetree/bindings/rtc/isil,isl1208.txt       | 38 ++++++++++++++++++=
++++
 .../devicetree/bindings/rtc/isil,isl1219.txt       | 29 -----------------
 2 files changed, 38 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/isil,isl1208.txt
 delete mode 100644 Documentation/devicetree/bindings/rtc/isil,isl1219.txt

diff --git a/Documentation/devicetree/bindings/rtc/isil,isl1208.txt b/Docum=
entation/devicetree/bindings/rtc/isil,isl1208.txt
new file mode 100644
index 000000000000..51f003006f04
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/isil,isl1208.txt
@@ -0,0 +1,38 @@
+Intersil ISL1209/19 I2C RTC/Alarm chip with event in
+
+ISL12X9 have additional pins EVIN and #EVDET for tamper detection, while t=
he
+ISL1208 and ISL1218 do not.  They are all use the same driver with the bin=
dings
+described here, with chip specific properties as noted.
+
+Required properties supported by the device:
+ - "compatible": Should be one of the following:
+		- "isil,isl1208"
+		- "isil,isl1209"
+		- "isil,isl1218"
+		- "isil,isl1219"
+ - "reg": I2C bus address of the device
+
+Optional properties:
+ - "interrupt-names": list which may contains "irq" and "evdet"
+	evdet applies to isl1209 and isl1219 only
+ - "interrupts": list of interrupts for "irq" and "evdet"
+	evdet applies to isl1209 and isl1219 only
+ - "isil,ev-evienb": Enable or disable internal pull on EVIN pin
+	Applies to isl1209 and isl1219 only
+	Possible values are 0 and 1
+	Value 0 enables internal pull-up on evin pin, 1 disables it.
+	Default will leave the non-volatile configuration of the pullup
+	as is.
+
+Example isl1219 node with #IRQ pin connected to SoC gpio1 pin12 and #EVDET=
 pin
+connected to SoC gpio2 pin 24 and internal pull-up enabled in EVIN pin.
+
+	isl1219: rtc@68 {
+		compatible =3D "isil,isl1219";
+		reg =3D <0x68>;
+		interrupt-names =3D "irq", "evdet";
+		interrupts-extended =3D <&gpio1 12 IRQ_TYPE_EDGE_FALLING>,
+			<&gpio2 24 IRQ_TYPE_EDGE_FALLING>;
+		isil,ev-evienb =3D <1>;
+	};
+
diff --git a/Documentation/devicetree/bindings/rtc/isil,isl1219.txt b/Docum=
entation/devicetree/bindings/rtc/isil,isl1219.txt
deleted file mode 100644
index c3efd48e91c2..000000000000
--- a/Documentation/devicetree/bindings/rtc/isil,isl1219.txt
+++ /dev/null
@@ -1,29 +0,0 @@
-Intersil ISL1219 I2C RTC/Alarm chip with event in
-
-ISL1219 has additional pins EVIN and #EVDET for tamper detection.
-
-Required properties supported by the device:
-
- - "compatible": must be "isil,isl1219"
- - "reg": I2C bus address of the device
-
-Optional properties:
-
- - "interrupt-names": list which may contains "irq" and "evdet"
- - "interrupts": list of interrupts for "irq" and "evdet"
- - "isil,ev-evienb": if present EV.EVIENB bit is set to the specified
-                     value for proper operation.
-
-
-Example isl1219 node with #IRQ pin connected to SoC gpio1 pin12
- and #EVDET pin connected to SoC gpio2 pin 24:
-
-	isl1219: rtc@68 {
-		compatible =3D "isil,isl1219";
-		reg =3D <0x68>;
-		interrupt-names =3D "irq", "evdet";
-		interrupts-extended =3D <&gpio1 12 IRQ_TYPE_EDGE_FALLING>,
-			<&gpio2 24 IRQ_TYPE_EDGE_FALLING>;
-		isil,ev-evienb =3D <1>;
-	};
-
--=20
2.14.4

