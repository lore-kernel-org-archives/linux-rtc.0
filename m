Return-Path: <linux-rtc-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:36846 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751520AbdF0P1t (ORCPT
        <rfc822;linux-rtc@vger.kernel.org>); Tue, 27 Jun 2017 11:27:49 -0400
MIME-Version: 1.0
In-Reply-To: <20170627130057.yhhalp2epmmdicz7@piout.net>
References: <1498150704-21777-1-git-send-email-yesipov@gmail.com>
 <CAHp75Vd-CoKpt0dhXspCDLSoohEVRTHEEPn9jZtFqUwvAeB1bA@mail.gmail.com>
 <CAJcpCzF1SJ2v-KsJXN7c=BogeQv4LdAZEgZFsgVVy3HKPCcO1Q@mail.gmail.com> <20170627130057.yhhalp2epmmdicz7@piout.net>
From: Kirill Esipov <yesipov@gmail.com>
Date: Tue, 27 Jun 2017 18:27:42 +0300
Message-ID: <CAJcpCzEHW8GSkykidpq=GBo-aFbFstmOmQZhAYu-NWBWxTc=uA@mail.gmail.com>
Subject: Re: [PATCH v2] rtc: ds3232: add temperature support
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-rtc-owner@vger.kernel.org
List-ID: <linux-rtc.vger.kernel.org>

2017-06-27 16:00 GMT+03:00 Alexandre Belloni
<alexandre.belloni@free-electrons.com>:
> On 27/06/2017 at 15:24:57 +0300, Kirill Esipov wrote:
>> 2017-06-25 19:39 GMT+03:00 Andy Shevchenko <andy.shevchenko@gmail.com>:
>> > On Thu, Jun 22, 2017 at 7:58 PM, Kirill Esipov <yesipov@gmail.com> wrote:
>> >> DS3232/DS3234 has the temperature registers with a resolution of 0.25
>> >> degree celsius. This enables to get the value through hwmon.
>> >>
>> >>         # cat /sys/class/hwmon/hwmon0/temp1_input
>> >>         37250
>> >
>> >> +config RTC_DRV_DS3232_HWMON
>> >> +       bool "HWMON support for Dallas/Maxim DS3232/DS3234"
>> >
>> >> +       depends on RTC_DRV_DS3232 && HWMON
>> >> +       depends on !(RTC_DRV_DS3232=y && HWMON=m)
>> >
>> > Perhaps it might be squeezed into one line (something like that logic
>> > has been required by I2C related PMIC IIRC)
>> >
>> >> +       default y
>> >
>> > Is it really sane default?
>> >
>>
>> At first sight i thought that yes it is sane default (and others RTC with
>> hwmon set it "default y" (ds1307, rv3029c2)).
>> But if it's not sane, then we should turn it off by default in others drivers?
>>
>
> It is definitively sane.
>
>>
>> >> +#ifdef CONFIG_RTC_DRV_DS3232_HWMON
>> >
>> > IS_BUILTIN() ?
>> >
>
> I'd use IS_ENABLED in that case.
>

Why? "RTC_DRV_DS3232_HWMON" is bool, not tristate. So it can't be
defined as "m".

>> >> +static int ds3232_hwmon_read_temp(struct device *dev, long int *mC)
>> >> +{
>> >> +       struct ds3232 *ds3232 = dev_get_drvdata(dev);
>> >> +       u8 temp_buf[2];
>> >> +       s16 temp;
>> >> +       int ret;
>> >> +
>> >> +       ret = regmap_bulk_read(ds3232->regmap, DS3232_REG_TEMPERATURE, temp_buf,
>> >> +                               sizeof(temp_buf));
>> >
>> >> +
>> >
>> > Remove.
>
> I'd recommend running checkpatch.pl --strict to remove the remaining
> whitespace issues too (a few alignments are off).
>
>> >
>> > I dunno which style is preferred, though you may use
>> > if (IS_BUILTIN(...))
>> >  return;
>> >
>> > at the beginning of the function and allow gcc optimizer to take care
>> > of everything else.
>> >
>
> I don't have a strong opinion there.
>
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com



-- 
Kirill Esipov
