Return-Path: <rtc-linux+bncBCQ6FHMJVICRBANOTW3QKGQE4IDW44Y@googlegroups.com>
Received: from ozlabs.org (ozlabs.org. [2401:3900:2:1::2])
        by gmr-mx.google.com with ESMTPS id ui7si3714265pab.0.2016.03.14.17.27.44
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Mar 2016 17:27:45 -0700 (PDT)
Date: Tue, 15 Mar 2016 11:27:41 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [GIT PULL] RTC for 4.6
Message-ID: <20160315112741.3d1d8a4c@canb.auug.org.au>
In-Reply-To: <20160314235831.GI28277@piout.net>
References: <20160314164549.GA20174@piout.net>
	<20160315105045.3c71952a@canb.auug.org.au>
	<20160314235831.GI28277@piout.net>
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

On Tue, 15 Mar 2016 00:58:31 +0100 Alexandre Belloni <alexandre.belloni@free-electrons.com> wrote:
>
> Indeed, I forgot to fixup a few commit messages a while ago and I did
> that before sending the PR. Is that an issue?

Not in this case (since the base is the same and the patches themselves
have not changed), but in general it does make it harder to see how
much testing etc the changes have had.

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
