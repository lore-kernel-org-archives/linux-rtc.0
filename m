Return-Path: <rtc-linux+bncBDT6DFON3EBBBVGUUC2QKGQEXCYPARQ@googlegroups.com>
Received: from mail-yk0-x242.google.com (mail-yk0-x242.google.com. [2607:f8b0:4002:c07::242])
        by gmr-mx.google.com with ESMTPS id q187si420860ywf.4.2016.01.26.18.24.20
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2016 18:24:20 -0800 (PST)
Received: by mail-yk0-x242.google.com with SMTP id k129so16147595yke.3
        for <rtc-linux@googlegroups.com>; Tue, 26 Jan 2016 18:24:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56A82475.1040602@samsung.com>
References: <1453836020-29579-1-git-send-email-javier@osg.samsung.com>
	<1453836020-29579-7-git-send-email-javier@osg.samsung.com>
	<56A82475.1040602@samsung.com>
Date: Tue, 26 Jan 2016 23:24:20 -0300
Message-ID: <CABxcv==M4X7gS7ojtF4qWoakss43wLPLxFM5_CVzGTpPN2BAuQ@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH v3 06/10] rtc: max77686: Add max77802 support
From: Javier Martinez Canillas <javier@dowhile0.org>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
	Kukjin Kim <kgene@kernel.org>, rtc-linux@googlegroups.com,
	Chanwoo Choi <cw00.choi@samsung.com>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	"linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hello Krzysztof,

On Tue, Jan 26, 2016 at 10:59 PM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> On 27.01.2016 04:20, Javier Martinez Canillas wrote:

[snip]

>>       data[RTC_MONTH] = tm->tm_mon + 1;
>> -     data[RTC_YEAR] = tm->tm_year > 100 ? (tm->tm_year - 100) : 0;
>>
>> -     if (tm->tm_year < 100) {
>> -             pr_warn("RTC cannot handle the year %d.  Assume it's 2000.\n",
>> -                     1900 + tm->tm_year);
>> -             return -EINVAL;
>> +     if (!info->drv_data->alarm_enable_reg) {
>
> I don't like all these inverted checks. They are error-prone. This is
> why I propose different name. However since you want to stick to this
> name of this property, then easier to read would be:
>
> if (info->drv_data->alarm_enable_reg) {
>         data[RTC_YEAR] = tm->tm_year;
> } else {
>         max77686-stuff...
> }
> Can you reverse it here and in other places?
>

Fair enough, I'll reverse the logic so is more natural and also do an
early return as Andi suggested.

> The patch beside that is okay and works fine:
>
> Tested on Trats2 (max77686):
> Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
>
> BR,
> Krzysztof
>

Best regards,
Javier

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
