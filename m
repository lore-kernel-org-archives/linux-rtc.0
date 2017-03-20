Return-Path: <rtc-linux+bncBCQJP74GSUDRB7P2X7DAKGQELOT7HUA@googlegroups.com>
Received: from mail-it0-x22c.google.com (mail-it0-x22c.google.com. [2607:f8b0:4001:c0b::22c])
        by gmr-mx.google.com with ESMTPS id d20si892761itc.1.2017.03.20.09.04.13
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Mar 2017 09:04:13 -0700 (PDT)
Received: by mail-it0-x22c.google.com with SMTP id w124so93321754itb.1
        for <rtc-linux@googlegroups.com>; Mon, 20 Mar 2017 09:04:13 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <SG2PR06MB1165819F41CF40562F44F08B8A3A0@SG2PR06MB1165.apcprd06.prod.outlook.com>
References: <20170316175112.27913-1-chris.brandt@renesas.com>
 <20170316175112.27913-3-chris.brandt@renesas.com> <CAMuHMdVu0dQjptyW0F5YS+V6sixXTM3P6VWq2=8BQ5njUOXf-Q@mail.gmail.com>
 <SG2PR06MB1165A9931C930DF9BCD5C0A98A390@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <CAMuHMdW0nHiZkE_RxVLX3G0MuwQLPHVFyNq5C1tx0yAqDQefaA@mail.gmail.com>
 <SG2PR06MB11653BB788CADBEE78FE4CF58A390@SG2PR06MB1165.apcprd06.prod.outlook.com>
 <CAMuHMdWs3NtKLiBnKCmxGYNBW3zzWYydj=JGKr+mH7ao97L2_Q@mail.gmail.com>
 <20170317150524.oijto6gtjxycdnwn@piout.net> <SG2PR06MB1165819F41CF40562F44F08B8A3A0@SG2PR06MB1165.apcprd06.prod.outlook.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 20 Mar 2017 17:03:20 +0100
Message-ID: <CAMuHMdWxs4Xwc0T5AHL73ZtF6r8pN9v6g-GEzozdLvTc4j4aSw@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH 2/5] rtc: Add rtc-sh
To: Chris Brandt <Chris.Brandt@renesas.com>
Cc: Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Alessandro Zummo <a.zummo@towertech.it>, Rob Herring <robh+dt@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>, Simon Horman <horms+renesas@verge.net.au>,
	RTCLINUX <rtc-linux@googlegroups.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Chris,

On Mon, Mar 20, 2017 at 4:05 PM, Chris Brandt <Chris.Brandt@renesas.com> wrote:
> On Friday, March 17, 2017, Alexandre Belloni wrote:
>> On 17/03/2017 at 14:55:48 +0100, Geert Uytterhoeven wrote:
>> > >> it would still be good to have phandles to the external clock
>> > >> sources as well, as that describes the hardware topology.
>> > > I'm confused, you mean make new clocks node for RTC_X1 (fixed at
>> > > 32.768kHZ) and
>> > > RTC_X3 (fixed at 4MHz), but then not really do anything with then?
>> > > (the driver
>> >
>> > You still do something with them, as they'll be linked from the rtc
>> device node.
>> >
>> > > doesn't need them)
>> >
>> > The driver may use them in the future.
>> > E.g. to select among X1, X3, or EXTAL, depending on availability.
>>
>> I'm on Geert's side here, I wouldn't rely on the bootloader to set
>> everything up correctly.
>
> Part of my hesitation to putting in the clock source selection was that
> this RTC block is used in a lot of parts, and it's always the same,
> except for the last 3 registers which are different from device to
> device because different SoCs have different clock sources options
> and ways to set them up. So, making a driver that just 'reads' the
> time seemed safer/easier.
> Anyway, I'll add the clock setup in if that's the general consensus.
>
> But, before I send out an updated version, what were you thinking
> my DT should look like?
>
> Should I make a "count-source" property for user to select what clock
> will be used for the actually counting?
>
>
>         clocks {
>                 ranges;
>                 #address-cells = <1>;
>                 #size-cells = <1>;
>             . . .
>
> +               rtc_x1_clk: rtc_x1 {
> +                       #clock-cells = <0>;
> +                       compatible = "fixed-clock";
> +                       /* If clk present, value must be set by board to 32678 */
> +                       clock-frequency = <0>;
> +               };
> +
> +               rtc_x3_clk: rtc_x3 {
> +                       #clock-cells = <0>;
> +                       compatible = "fixed-clock";
> +                       /* If clk present, value must be set by board to 4000000 */
> +                       clock-frequency = <0>;
> +               };
> +
>
>
>
>
> +       rtc: rtc@fcff1000 {
> +               compatible = "renesas,r7s72100-rtc", "renesas,sh-rtc";
> +               reg = <0xfcff1000 0x2e>;
> +               interrupts = <GIC_SPI 276 IRQ_TYPE_EDGE_RISING
> +                             GIC_SPI 277 IRQ_TYPE_EDGE_RISING
> +                             GIC_SPI 278 IRQ_TYPE_EDGE_RISING>;
> +               interrupt-names = "alarm", "period", "carry";
> +               clocks = <&mstp6_clks R7S72100_CLK_RTC>, <&rtc_x1_clk>,
> +                         <&extal_clk> , <&rtc_x3_clk>;
> +               clock-names = "fck", "rtc_x1", "extal", "rtc_x3";
> +               power-domains = <&cpg_clocks>;
> +               count-source = "rtc_x1";    <<<<<<< this would be in the board dts file

IMHO that's software policy, not hardware description, so it doesn't
belong in DT.

However, by scanning the list of allowed clock names, and looking at clock
rates, the driver can find a suitable clock itself.

> +               status = "disabled";
> +       };

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
