Return-Path: <rtc-linux+bncBCQI7JPS3IGRBOULXW4AKGQEZ6HQH3A@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com. [2607:f8b0:4002:c05::242])
        by gmr-mx.google.com with ESMTPS id i191si2293019ywe.6.2016.04.14.00.24.42
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Apr 2016 00:24:42 -0700 (PDT)
Received: by mail-yw0-x242.google.com with SMTP id k197so9909706ywe.2
        for <rtc-linux@googlegroups.com>; Thu, 14 Apr 2016 00:24:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160414071902.GK7765@piout.net>
References: <570EAE8B.7010706@nkgroup.cz>
	<20160413224916.GH7765@piout.net>
	<CAAJk-V1p5+sirH9wF1ucvjuCbpFVVR2iJ+cW7A7eBhRx_=91yQ@mail.gmail.com>
	<20160414071902.GK7765@piout.net>
Date: Thu, 14 Apr 2016 09:24:41 +0200
Message-ID: <CAAJk-V1M-wRMOt0BYk+Nnrb805A8wwji0yyzT2OPfGoCWuruaw@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH] rtc: support for rv4162c7
From: Tomas Krcka <tomas.krcka@nkgroup.cz>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: rtc-linux@googlegroups.com, Alessandro Zummo <a.zummo@towertech.it>,
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,
  ok, good. Thanks.
Patch is not needed.

2016-04-14 9:19 GMT+02:00 Alexandre Belloni
<alexandre.belloni@free-electrons.com>:
> Hi,
>
> On 14/04/2016 at 08:29:47 +0200, Tomas Krcka wrote :
>> Hi,
>>   that's correct, but idetification of this chip is rv4162c7 so
>> i2c_match_id() returns NULL.
>> If it's there any workaround, how the chip can be detected
>> automatically then OK, but without this patch it doesn't work for me.
>>
>
> Just use rv4162 as your compatible string. That is what the mainline dtsi
> is doing for the phycore som:
>
> $ grep -C 2 rv4162 arch/arm/boot/dts/am335x-phycore-som.dtsi
>
>         i2c_rtc: rtc@68 {
>                 compatible = "rv4162";
>                 reg = <0x68>;
>                 status = "disabled";
>
>
>> 2016-04-14 0:49 GMT+02:00 Alexandre Belloni
>> <alexandre.belloni@free-electrons.com>:
>> > Hi,
>> >
>> > On 13/04/2016 at 22:39:39 +0200, Tomas Krcka wrote :
>> >> This patch is for support of rv4162c7 RTC chip.
>> >> The device has same parameters as rv4162, but with different identification.
>> >> Tested with PhyTec module AM335x.
>> >>
>> >
>> > Well, technically, it is an rv4162. rv4162-c7 is the only available one.
>> > So this patch is not necessary.
>> >
>> >> Signed-off-by: Tomas Krcka <tomas.krcka@nkgroup.cz>
>> >>
>> >> ---
>> >>  drivers/rtc/rtc-m41t80.c | 1 +
>> >>  1 file changed, 1 insertion(+)
>> >>
>> >> diff --git a/drivers/rtc/rtc-m41t80.c b/drivers/rtc/rtc-m41t80.c
>> >> index d107a8e..1aa57d8 100644
>> >> --- a/drivers/rtc/rtc-m41t80.c
>> >> +++ b/drivers/rtc/rtc-m41t80.c
>> >> @@ -81,6 +81,7 @@ static const struct i2c_device_id m41t80_id[] = {
>> >>      { "m41st85", M41T80_FEATURE_HT | M41T80_FEATURE_BL | M41T80_FEATURE_SQ },
>> >>      { "m41st87", M41T80_FEATURE_HT | M41T80_FEATURE_BL | M41T80_FEATURE_SQ },
>> >>      { "rv4162", M41T80_FEATURE_SQ | M41T80_FEATURE_WD | M41T80_FEATURE_SQ_ALT },
>> >> +    { "rv4162c7", M41T80_FEATURE_SQ | M41T80_FEATURE_WD | M41T80_FEATURE_SQ_ALT },
>> >>      { }
>> >>  };
>> >>  MODULE_DEVICE_TABLE(i2c, m41t80_id);
>> >> -- 1.9.1
>> >>
>> >
>> > --
>> > Alexandre Belloni, Free Electrons
>> > Embedded Linux, Kernel and Android engineering
>> > http://free-electrons.com
>
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com

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
