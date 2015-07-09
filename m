Return-Path: <rtc-linux+bncBCQJP74GSUDRBKXT7CWAKGQEGSCRWNY@googlegroups.com>
Received: from mail-oi0-x229.google.com (mail-oi0-x229.google.com. [2607:f8b0:4003:c06::229])
        by gmr-mx.google.com with ESMTPS id o7si502597igp.1.2015.07.09.02.06.50
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Jul 2015 02:06:50 -0700 (PDT)
Received: by mail-oi0-x229.google.com with SMTP id y130so185039794oiy.0
        for <rtc-linux@googlegroups.com>; Thu, 09 Jul 2015 02:06:50 -0700 (PDT)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7014B23FDDA@SW-EX-MBX02.diasemi.com>
References: <cover.1436427954.git.stwiss.opensource@diasemi.com>
	<CAMuHMdU_AUZ9nxo25NeaFq1MeeSDZErqkNnDtXsdr7=jLm1kTw@mail.gmail.com>
	<6ED8E3B22081A4459DAC7699F3695FB7014B23FDDA@SW-EX-MBX02.diasemi.com>
Date: Thu, 9 Jul 2015 11:06:50 +0200
Message-ID: <CAMuHMdWYJyzrBsMMJciyvkopAfA-omrD-eEsC2XhCvCeDBd+uQ@mail.gmail.com>
Subject: [rtc-linux] Re: [PATCH RFC V1 0/3] da9062: Add DA9062 RTC support
 using the existing DA9063 RTC driver
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Opensource [Steve Twiss]" <stwiss.opensource@diasemi.com>
Cc: Alessandro Zummo <a.zummo@towertech.it>,
	Alexandre Belloni <alexandre.belloni@free-electrons.com>,
	DEVICETREE <devicetree@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>, LINUXINPUT <linux-input@vger.kernel.org>,
	LINUXKERNEL <linux-kernel@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>,
	Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>,
	RTCLINUX <rtc-linux@googlegroups.com>, Rob Herring <robh+dt@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>, David Dajun Chen <david.chen@diasemi.com>,
	Support Opensource <Support.Opensource@diasemi.com>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Thu, Jul 9, 2015 at 10:42 AM, Opensource [Steve Twiss]
<stwiss.opensource@diasemi.com> wrote:
>> > S Twiss (3):
>> >   mfd: da9062: Support for the DA9063 RTC in the DA9062 core
>>
>> "DA9062 RTC"?
>>
>
> Hi Geert,
>
> It's the support for the "DA9063 RTC *driver* in the DA9062 MFD driver core".

Ah, I read "core" as in "hardware IP core".

And as the full patch description for [1/3] doesn't say "da9063" elsewhere,
I thought it was a typo.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

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
