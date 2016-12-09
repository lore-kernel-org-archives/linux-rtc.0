Return-Path: <rtc-linux+bncBC6YH6VTZQDRBVF3VPBAKGQE4HVWERY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (mail.free-electrons.com. [62.4.15.54])
        by gmr-mx.google.com with ESMTP id d22si1021348wmd.0.2016.12.09.08.37.40
        for <rtc-linux@googlegroups.com>;
        Fri, 09 Dec 2016 08:37:40 -0800 (PST)
From: Gregory CLEMENT <gregory.clement@free-electrons.com>
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Alessandro Zummo <a.zummo@towertech.it>,  Alexandre Belloni <alexandre.belloni@free-electrons.com>,  rtc-linux@googlegroups.com,  Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,  Andrew Lunn <andrew@lunn.ch>,  Jason Cooper <jason@lakedaemon.net>,  Shaker Daibes <shaker@marvell.com>,  linux-arm-kernel@lists.infradead.org,  Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [rtc-linux] Re: [PATCH 1/3] rtc: armada38x: improve RTC errata implementation
References: <20161208171010.29446-1-gregory.clement@free-electrons.com>
	<20161208171010.29446-2-gregory.clement@free-electrons.com>
	<20161208173717.GJ14217@n2100.armlinux.org.uk>
Date: Fri, 09 Dec 2016 17:37:34 +0100
In-Reply-To: <20161208173717.GJ14217@n2100.armlinux.org.uk> (Russell King's
	message of "Thu, 8 Dec 2016 17:37:17 +0000")
Message-ID: <871sxhf48h.fsf@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi Russell King,
=20
 On jeu., d=C3=A9c. 08 2016, Russell King - ARM Linux <linux@armlinux.org.u=
k> wrote:

> On Thu, Dec 08, 2016 at 06:10:08PM +0100, Gregory CLEMENT wrote:
>> From: Shaker Daibes <shaker@marvell.com>
>>=20
>> According to FE-3124064:
>> The device supports CPU write and read access to the RTC time register.
>> However, due to this errata, read from RTC TIME register may fail.
>>=20
>> Workaround:
>> General configuration:
>> 1. Configure the RTC Mbus Bridge Timing Control register (offset 0x184A0=
)
>>    to value 0xFD4D4FFF
>>    Write RTC WRCLK Period to its maximum value (0x3FF)
>>    Write RTC WRCLK setup to 0x53 (default value )
>>    Write RTC WRCLK High Time to 0x53 (default value )
>>    Write RTC Read Output Delay to its maximum value (0x1F)
>>    Mbus - Read All Byte Enable to 0x1 (default value )
>> 2. Configure the RTC Test Configuration Register (offset 0xA381C) bit3
>>    to '1' (Reserved, Marvell internal)
>>=20
>> For any RTC register read operation:
>> 1. Read the requested register 100 times.
>> 2. Find the result that appears most frequently and use this result
>>    as the correct value.
>>=20
>> For any RTC register write operation:
>> 1. Issue two dummy writes of 0x0 to the RTC Status register (offset
>>    0xA3800).
>> 2. Write the time to the RTC Time register (offset 0xA380C).
>>=20
>> [gregory.clement@free-electrons.com: cosmetic changes and fix issues for
>> interrupt in original patch]
>
> A particularly interesting question here is whether the above description
> came first or whether the code below came first, and which was derived
> from which.

Well, it is difficult to say. the above description comes from the
errata datasheet (since rev B). But the errata sheet itself mentioned
the software implementation in one of the Marvell release.=20


>
> Given that both readl() writel() involves a barrier operation, which is
> not mentioned in the above workaround text, is it appropriate to use the
> barriered operations?

Do you suggest to use the the relaxed version of readl() and writel()?

>
>>=20
>> Reviewed-by: Lior Amsalem <alior@marvell.com>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  drivers/rtc/rtc-armada38x.c | 109 ++++++++++++++++++++++++++++++++++---=
-------
>>  1 file changed, 85 insertions(+), 24 deletions(-)
>>=20
>> diff --git a/drivers/rtc/rtc-armada38x.c b/drivers/rtc/rtc-armada38x.c
>> index 9a3f2a6f512e..a0859286a4c4 100644
>> --- a/drivers/rtc/rtc-armada38x.c
>> +++ b/drivers/rtc/rtc-armada38x.c
>> @@ -29,12 +29,21 @@
>>  #define RTC_TIME	    0xC
>>  #define RTC_ALARM1	    0x10
>> =20
>> +#define SOC_RTC_BRIDGE_TIMING_CTL   0x0
>> +#define SOC_RTC_PERIOD_OFFS		0
>> +#define SOC_RTC_PERIOD_MASK		(0x3FF << SOC_RTC_PERIOD_OFFS)
>> +#define SOC_RTC_READ_DELAY_OFFS		26
>> +#define SOC_RTC_READ_DELAY_MASK		(0x1F << SOC_RTC_READ_DELAY_OFFS)
>> +
>>  #define SOC_RTC_INTERRUPT   0x8
>>  #define SOC_RTC_ALARM1		BIT(0)
>>  #define SOC_RTC_ALARM2		BIT(1)
>>  #define SOC_RTC_ALARM1_MASK	BIT(2)
>>  #define SOC_RTC_ALARM2_MASK	BIT(3)
>> =20
>> +
>> +#define SAMPLE_NR 100
>> +
>>  struct armada38x_rtc {
>>  	struct rtc_device   *rtc_dev;
>>  	void __iomem	    *regs;
>> @@ -47,32 +56,85 @@ struct armada38x_rtc {
>>   * According to the datasheet, the OS should wait 5us after every
>>   * register write to the RTC hard macro so that the required update
>>   * can occur without holding off the system bus
>> + * According to errata FE-3124064, Write to any RTC register
>> + * may fail. As a workaround, before writing to RTC
>> + * register, issue a dummy write of 0x0 twice to RTC Status
>> + * register.
>>   */
>> +
>>  static void rtc_delayed_write(u32 val, struct armada38x_rtc *rtc, int o=
ffset)
>>  {
>> +	writel(0, rtc->regs + RTC_STATUS);
>> +	writel(0, rtc->regs + RTC_STATUS);
>>  	writel(val, rtc->regs + offset);
>>  	udelay(5);
>>  }
>> =20
>> +/* Update RTC-MBUS bridge timing parameters */
>> +static void rtc_update_mbus_timing_params(struct armada38x_rtc *rtc)
>> +{
>> +	uint32_t reg;
>> +
>> +	reg =3D readl(rtc->regs_soc + SOC_RTC_BRIDGE_TIMING_CTL);
>> +	reg &=3D ~SOC_RTC_PERIOD_MASK;
>> +	reg |=3D 0x3FF << SOC_RTC_PERIOD_OFFS; /* Maximum value */
>> +	reg &=3D ~SOC_RTC_READ_DELAY_MASK;
>> +	reg |=3D 0x1F << SOC_RTC_READ_DELAY_OFFS; /* Maximum value */
>> +	writel(reg, rtc->regs_soc + SOC_RTC_BRIDGE_TIMING_CTL);
>> +}
>> +
>> +struct str_value_to_freq {
>> +	unsigned long value;
>> +	u8 freq;
>> +} __packed;
>
> Why packed?  This makes accesses to this structure very inefficient -
> the compiler for some CPUs will load "value" by bytes.

As pointed by Andrew, I think the intent was to reduce the amount of
memory used from the stack.

Thanks,

Gregory

--=20
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com

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
