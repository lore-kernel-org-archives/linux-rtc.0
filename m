Return-Path: <rtc-linux+bncBCGP7DNSRUMRBSVP32VQKGQEFRIUHTA@googlegroups.com>
Received: from mail-wg0-x22f.google.com (mail-wg0-x22f.google.com. [2a00:1450:400c:c00::22f])
        by gmr-mx.google.com with ESMTPS id ec7si177997wib.3.2015.06.09.18.50.02
        for <rtc-linux@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2015 18:50:02 -0700 (PDT)
Received: by mail-wg0-x22f.google.com with SMTP id z8so24627345wge.0
        for <rtc-linux@googlegroups.com>; Tue, 09 Jun 2015 18:50:02 -0700 (PDT)
MIME-Version: 1.0
Sender: rtc-linux@googlegroups.com
In-Reply-To: <20150609074946.GG5222@piout.net>
References: <1390339396-3479-43-git-send-email-paul.gortmaker@windriver.com>
 <20150608195455.GF5222@piout.net> <20150608210634.GJ7125@windriver.com> <20150609074946.GG5222@piout.net>
From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Tue, 9 Jun 2015 21:49:31 -0400
Message-ID: <CAP=VYLpGg0WkYVd6KcCg-j50pYNLRSXKxo1a6SwoT4cNm6CaSw@mail.gmail.com>
Subject: [rtc-linux] Re: [42/73] rtc: delete non-required instances of include <linux/init.h>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On Tue, Jun 9, 2015 at 3:49 AM, Alexandre Belloni
<alexandre.belloni@free-electrons.com> wrote:
> On 08/06/2015 at 17:06:34 -0400, Paul Gortmaker wrote :
>> > I've contemplated applying that patch but I'm not sure it is actually a
>> > good idea because those 46 drivers are using a variant of module_driver
>> > which actually uses __init and __exit. After your patch it is still
>> > working simply because init.h gets included that way:
>>
>> Firstly, I am kind of curious why an 18 month old patch is getting
>> replied to now.   That aside, this interdependence between module.h and
>> init.h was reconsidered and you can see the resolution solution here:
>>
>> https://lkml.kernel.org/r/1433276168-21550-1-git-send-email-paul.gortmaker@windriver.com
>>
>> To summarize what is said there, yes - you can ignore the one line
>> removals for now.  We will revisit them after the above is merged.
>>
>
> I've taken the RTC subsystem maintainership and I've been sorting the
> 2372 patches left in patchwork down to 126 and yours was one of these.
>
> Seeing your answer, I think my question was legitimate. I'll be happy to
> take your revised patch once ready.

Yes, it was a legit (and correct) spotting ; just some months late.  :)

I'll be sure to make sure you are CC'd on any updates.  And thanks
for taking over maintainership of the rtc subsystem.   I'll go out on
a limb here and guess that the original rtc driver author ; that idiot
never imagined it would become a subsystem, else he'd thank you
as well.

Paul.
--

>
> --
> Alexandre Belloni, Free Electrons
> Embedded Linux, Kernel and Android engineering
> http://free-electrons.com
> --
> To unsubscribe from this list: send the line "unsubscribe linux-arch" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

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
