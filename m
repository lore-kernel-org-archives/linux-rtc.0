Return-Path: <rtc-linux+bncBDP6N55ZUYDRBDFLW2WQKGQE32XKSNI@googlegroups.com>
Received: from mail-lb0-x22e.google.com (mail-lb0-x22e.google.com. [2a00:1450:4010:c04::22e])
        by gmr-mx.google.com with ESMTPS id vp9si627825lbb.3.2015.07.20.17.42.52
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2015 17:42:52 -0700 (PDT)
Received: by mail-lb0-x22e.google.com with SMTP id zr7so105409403lbb.1
        for <rtc-linux@googlegroups.com>; Mon, 20 Jul 2015 17:42:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJKOXPcXszaRxVnm2H9XAB-diLfitCadfsL0u2UNwXg_ZBT2HA@mail.gmail.com>
References: <1437433372-15425-1-git-send-email-dmitry.torokhov@gmail.com>
	<CAJKOXPcXszaRxVnm2H9XAB-diLfitCadfsL0u2UNwXg_ZBT2HA@mail.gmail.com>
Date: Mon, 20 Jul 2015 17:42:51 -0700
Message-ID: <CAKdAkRQCeZaeZaBB1DzPdcFbk9swdGx9EZ7GU3+3p_eqwxxZPA@mail.gmail.com>
Subject: Re: [rtc-linux] [PATCH 1/4] RTC: fix double free in
 rtc_register_device() error path
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Cc: RTCLINUX <rtc-linux@googlegroups.com>, Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>, lkml <linux-kernel@vger.kernel.org>,
	Vasiliy Kulikov <segooon@gmail.com>
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

On Mon, Jul 20, 2015 at 5:32 PM, Krzysztof Kozlowski
<k.kozlowski@samsung.com> wrote:
> 2015-07-21 8:02 GMT+09:00 Dmitry Torokhov <dmitry.torokhov@gmail.com>:
>> Commit 59cca865f21e9e7beab73fcf79ba4eb776a4c228 correctly noted that naked
>> kfree() should not be used after failed device_register() call, however,
>> while it added the needed put_device() it forgot to remove the original
>> kfree() causing double-free.
>>
>> Cc: Vasiliy Kulikov <segooon@gmail.com>
>> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>> ---
>>  drivers/rtc/class.c | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> I think it can be cc'ed stable (with fixes tag).

I considered that, but it does not happen on normally working systems.
I'll leave it up to maintainers to annotate as they see fit.

Thanks.

-- 
Dmitry

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
