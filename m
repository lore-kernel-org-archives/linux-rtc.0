Return-Path: <rtc-linux+bncBCHOPY7NVYCRB2X35CVAKGQEIV6IKRA@googlegroups.com>
Received: from mail-ob0-x230.google.com (mail-ob0-x230.google.com. [2607:f8b0:4003:c01::230])
        by gmr-mx.google.com with ESMTPS id qr9si803845igb.0.2015.05.18.12.30.50
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2015 12:30:50 -0700 (PDT)
Received: by mail-ob0-x230.google.com with SMTP id lk2so138860000obb.0
        for <rtc-linux@googlegroups.com>; Mon, 18 May 2015 12:30:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1431938725.3209.15.camel@pengutronix.de>
References: <1431696990-23078-1-git-send-email-Frank.Li@freescale.com>
	<1431696990-23078-5-git-send-email-Frank.Li@freescale.com>
	<1431938725.3209.15.camel@pengutronix.de>
Date: Mon, 18 May 2015 14:30:50 -0500
Message-ID: <CAHrpEqSxgqUSWFkAh+R4K1oShsWfErE4nndxkYGGktMdkb3=xw@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 4/7] arm: dts: imx: update snvs to use syscon
 access register
From: Zhi Li <lznuaa@gmail.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: "Frank.Li@freescale.com" <Frank.Li@freescale.com>, Shawn Guo <shawn.guo@linaro.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, a.zummo@towertech.it,
	alexandre.belloni@free-electrons.com, sachin.kamat@linaro.org,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org,
	rtc-linux@googlegroups.com, linux-pm@vger.kernel.org,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Mon, May 18, 2015 at 3:45 AM, Philipp Zabel <p.zabel@pengutronix.de> wrote:
> Hi Frank,
>
> Am Freitag, den 15.05.2015, 21:36 +0800 schrieb Frank.Li@freescale.com:
>> From: Frank Li <Frank.Li@freescale.com>
>>
>> snvs is MFP device. Change dts to use syscon to allocate register resource.
>>
>> Signed-off-by: Frank Li <Frank.Li@freescale.com>
>> ---
>>  arch/arm/boot/dts/imx6qdl.dtsi | 12 ++++--------
>>  arch/arm/boot/dts/imx6sl.dtsi  | 12 ++++--------
>>  arch/arm/boot/dts/imx6sx.dtsi  | 12 ++++--------
>>  arch/arm/boot/dts/vfxxx.dtsi   |  9 +++------
>>  4 files changed, 15 insertions(+), 30 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
>> index 0482a66..6d8161d 100644
>> --- a/arch/arm/boot/dts/imx6qdl.dtsi
>> +++ b/arch/arm/boot/dts/imx6qdl.dtsi
>> @@ -687,21 +687,17 @@
>>                       };
>>
>>                       snvs@020cc000 {
>> -                             compatible = "fsl,sec-v4.0-mon", "simple-bus";
>> -                             #address-cells = <1>;
>> -                             #size-cells = <1>;
>> -                             ranges = <0 0x020cc000 0x4000>;
>> +                             compatible = "fsl,sec-v4.0-mon", "syscon",  "simple-bus";
>
> The compatible should change from "simple-bus" to "simple-mfd", then.

After change to simple-mfd,  driver can't been probed. Anything missed?

>
> regards
> Philipp
>

-- 
-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
