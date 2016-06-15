Return-Path: <rtc-linux+bncBCMILY6JWQBBBGNLQW5QKGQEQVLRUPY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from smtp.csie.ntu.edu.tw (smtp.csie.ntu.edu.tw. [140.112.30.61])
        by gmr-mx.google.com with ESMTPS id 62si3818887pfx.1.2016.06.15.06.18.17
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jun 2016 06:18:17 -0700 (PDT)
Received: from mail-it0-f41.google.com (mail-it0-f41.google.com [209.85.214.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: b93043)
	by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id 49D3120510
	for <rtc-linux@googlegroups.com>; Wed, 15 Jun 2016 21:18:15 +0800 (CST)
Received: by mail-it0-f41.google.com with SMTP id h190so19692284ith.1
        for <rtc-linux@googlegroups.com>; Wed, 15 Jun 2016 06:18:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160615124943.GE4948@dell>
References: <1465986467-14802-1-git-send-email-wens@csie.org>
 <1465986467-14802-3-git-send-email-wens@csie.org> <20160615124943.GE4948@dell>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 15 Jun 2016 21:17:49 +0800
Message-ID: <CAGb2v66q0h_BZ-kkRZCneOs5yxvcADXKymMskr3CRc-N8Dqm1A@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v2 02/10] mfd: ac100: Add device tree bindings
 for X-Powers AC100 codec/RTC combo IC
To: Lee Jones <lee.jones@linaro.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>,
	Maxime Ripard <maxime.ripard@free-electrons.com>,
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>,
	rtc-linux@googlegroups.com, linux-kernel <linux-kernel@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-clk <linux-clk@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Wed, Jun 15, 2016 at 8:49 PM, Lee Jones <lee.jones@linaro.org> wrote:
> On Wed, 15 Jun 2016, Chen-Yu Tsai wrote:
>
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>>  Documentation/devicetree/bindings/mfd/ac100.txt | 42 ++++++++++++++++++=
+++++++
>>  1 file changed, 42 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/ac100.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/ac100.txt b/Documenta=
tion/devicetree/bindings/mfd/ac100.txt
>> new file mode 100644
>> index 000000000000..fbab623e6fba
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/mfd/ac100.txt
>> @@ -0,0 +1,42 @@
>> +X-Powers AC100 Codec/RTC IC device tree bindings
>> +
>> +AC100 is a audio codec and RTC subsystem combo IC. The 2 parts are
>> +separated, including power supplies and interrupt lines, but share
>> +a common register address space and host interface.
>> +
>> +Required properties:
>> +- compatible: "x-powers,ac100"
>> +- reg: The I2C slave address or RSB hardware address for the chip
>> +- sub-nodes:
>> +  - codec
>> +    - compatible: "x-powers,ac100-codec"
>> +    - interrupt-parent: The parent interrupt controller
>> +    - interrupts: SoC NMI / GPIO interrupt connected to the IRQ_AUDIO p=
in
>> +  - rtc
>> +    - compatible: "x-powers,ac100-rtc"
>> +    - interrupt-parent: The parent interrupt controller
>> +    - interrupts: SoC NMI / GPIO interrupt connected to the IRQ_RTC pin
>> +    - #clock-cells: shall be 1
>> +    - clock-output-names: "cko1_rtc", "cko2_rtc", "cko3_rtc"
>> +    - see clock/clock-bindings.txt for common clock bindings
>> +
>> +Example:
>> +
>> +ac100: codec@e89 {
>> +     compatible =3D "x-powers,ac100";
>> +     reg =3D <0xe89>;
>> +
>> +     ac100_codec {
>> +             compatible =3D "x-powers,ac100-codec";
>> +             interrupt-parent =3D <&nmi_intc>;
>> +             interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
>> +     };
>> +
>> +     ac100_rtc {
>> +             compatible =3D "x-powers,ac100-rtc";
>> +             interrupt-parent =3D <&nmi_intc>;
>> +             interrupts =3D <0 IRQ_TYPE_LEVEL_LOW>;
>
> Isn't this the same interrupt as above?  Is it shared?

Copy paste error... The codec uses a different line in the design.

ChenYu

>
>> +             #clock-cells =3D <1>;
>> +             clock-output-names =3D "cko1_rtc", "cko2_rtc", "cko3_rtc";
>> +     };
>> +};
>
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org =E2=94=82 Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog

--=20
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
---=20
You received this message because you are subscribed to the Google Groups "=
rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
