Return-Path: <rtc-linux+bncBDS7HNEFSALRBG7PQK5AKGQEGDVIQQY@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id a65si88295wma.0.2016.05.21.12.31.38
        for <rtc-linux@googlegroups.com>;
        Sat, 21 May 2016 12:31:38 -0700 (PDT)
Date: Sat, 21 May 2016 21:31:38 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: rtc-linux@googlegroups.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [rtc-linux] Re: [GIT PULL] RTC for 4.7
Message-ID: <20160521193138.GB4204@piout.net>
References: <20160521151530.GA24382@piout.net>
 <CA+55aFyeoigaXBFPXzhL6_SJz+qNYnGN1vWx1s2LxABwDsHLYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <CA+55aFyeoigaXBFPXzhL6_SJz+qNYnGN1vWx1s2LxABwDsHLYw@mail.gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 21/05/2016 at 11:18:15 -0700, Linus Torvalds wrote :
> On Sat, May 21, 2016 at 8:15 AM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
> >
> > Here is the pull-request for the RTC subsystem for 4.7.
> 
> Grr. I noticed this too late, but this has all been rebased very recently.
> 
> Don't f*cking do this! Why do I have to tell people every single merge window?
> 

Yeah, sorry about that. I realized I forgot to rework a few commit
messages (Fixes: tags and author names due to patchwork messing with
them) before applying so I did it before sending the pull request. I'll
abstain next time.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
