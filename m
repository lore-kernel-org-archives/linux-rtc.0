Return-Path: <rtc-linux+bncBCMILY6JWQBBBG5CVC5QKGQENDCAGEA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from smtp.csie.ntu.edu.tw (smtp.csie.ntu.edu.tw. [140.112.30.61])
        by gmr-mx.google.com with ESMTPS id un17si6223096pab.0.2016.06.21.21.16.26
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2016 21:16:26 -0700 (PDT)
Received: from mail-it0-f54.google.com (mail-it0-f54.google.com [209.85.214.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: b93043)
	by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id B2B5F20B14
	for <rtc-linux@googlegroups.com>; Wed, 22 Jun 2016 12:16:24 +0800 (CST)
Received: by mail-it0-f54.google.com with SMTP id h190so30814710ith.1
        for <rtc-linux@googlegroups.com>; Tue, 21 Jun 2016 21:16:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160621131443.GA29350@rob-hp-laptop>
References: <1466391138-12862-1-git-send-email-wens@csie.org>
 <1466391138-12862-3-git-send-email-wens@csie.org> <20160621131443.GA29350@rob-hp-laptop>
From: Chen-Yu Tsai <wens@csie.org>
Date: Wed, 22 Jun 2016 12:16:03 +0800
Message-ID: <CAGb2v64TYTi0_thF7Z8cdBE9dkbPUq9xAhmhegqH8efVx1oCFw@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v3 2/8] mfd: ac100: Add device tree bindings
 for X-Powers AC100 codec/RTC combo IC
To: Rob Herring <robh@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>,
	Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, Maxime Ripard <maxime.ripard@free-electrons.com>,
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

On Tue, Jun 21, 2016 at 9:14 PM, Rob Herring <robh@kernel.org> wrote:
> On Mon, Jun 20, 2016 at 10:52:12AM +0800, Chen-Yu Tsai wrote:
>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
>> ---
>> Changes since v2:
>>
>>   - Fix interrupt line for ac100_codec in provided example.
>>
>> ---
>>  Documentation/devicetree/bindings/mfd/ac100.txt | 42 +++++++++++++++++++++++++
>>  1 file changed, 42 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/mfd/ac100.txt
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/ac100.txt b/Documentation/devicetree/bindings/mfd/ac100.txt
>> new file mode 100644
>> index 000000000000..a793954bb952
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
>> +    - interrupts: SoC NMI / GPIO interrupt connected to the IRQ_AUDIO pin
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
>> +     compatible = "x-powers,ac100";
>> +     reg = <0xe89>;
>> +
>> +     ac100_codec {
>
> Use generic node names and no underscores:
>
> codec {

Right. I intended to add them as labels, not change the node names.

Thanks
ChenYu

>
>> +             compatible = "x-powers,ac100-codec";
>> +             interrupt-parent = <&r_pio>;
>> +             interrupts = <0 9 IRQ_TYPE_LEVEL_LOW>; /* PL9 */
>> +     };
>> +
>> +     ac100_rtc {
>
> rtc {
>
>> +             compatible = "x-powers,ac100-rtc";
>> +             interrupt-parent = <&nmi_intc>;
>> +             interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>> +             #clock-cells = <1>;
>> +             clock-output-names = "cko1_rtc", "cko2_rtc", "cko3_rtc";
>> +     };
>> +};
>> --
>> 2.8.1
>>

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
