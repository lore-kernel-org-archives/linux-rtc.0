Return-Path: <rtc-linux+bncBCQ6FHMJVICRBWU4TW3QKGQELEPASCI@googlegroups.com>
Received: from ozlabs.org (ozlabs.org. [2401:3900:2:1::2])
        by gmr-mx.google.com with ESMTPS id sf5si3680425pac.1.2016.03.14.16.50.49
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Mar 2016 16:50:49 -0700 (PDT)
Date: Tue, 15 Mar 2016 10:50:45 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [GIT PULL] RTC for 4.6
Message-ID: <20160315105045.3c71952a@canb.auug.org.au>
In-Reply-To: <20160314164549.GA20174@piout.net>
References: <20160314164549.GA20174@piout.net>
MIME-Version: 1.0
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

Hi Alexandre,

On Mon, 14 Mar 2016 17:45:49 +0100 Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
>
> Here is the pull-request for the RTC susbsystem for 4.6. It is based on
> v4.5-rc1 as arm-soc, through samsung-soc, depends on an immutable tag:
> rtc-max77686-4.6
> 
> The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:
> 
>   Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-4.6
> 
> for you to fetch changes up to cee2cc21550648679d222cbe2637fcc6d0f730ef:
> 
>   rtc: pcf2127: add pcf2129 device id (2016-03-14 17:08:41 +0100)

Partly rebased since yesterday - presumably to fix up some of the commit messages.

-- 
Cheers,
Stephen Rothwell

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
