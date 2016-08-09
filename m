Return-Path: <rtc-linux+bncBCKYNX7Y3IMBB4UTU66QKGQEN6UUXVQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id o10si130814wme.0.2016.08.09.05.17.54
        for <rtc-linux@googlegroups.com>;
        Tue, 09 Aug 2016 05:17:54 -0700 (PDT)
Date: Tue, 9 Aug 2016 14:17:53 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [rtc-linux] Re: [PATCH] rtc: pcf2123: Add missing error code
 assignment before test
Message-ID: <20160809121753.GZ8132@piout.net>
References: <1470743907-11498-1-git-send-email-christophe.jaillet@wanadoo.fr>
 <alpine.DEB.2.10.1608091403050.2911@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <alpine.DEB.2.10.1608091403050.2911@hadrien>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 09/08/2016 at 14:03:35 +0200, Julia Lawall wrote :
> 
> 
> On Tue, 9 Aug 2016, Christophe JAILLET wrote:
> 
> > It is likely that checking the result of 'pcf2123_write_reg' is expected
> > here.
> > Also fix a small style issue. The '{' at the beginning of the function
> > is misplaced.
> 
> They shouldn't be in the same patch.  If you are wrong about the ret
> issue, the { should still be moved.
> 

That is true but as it is a really trivial patch, I didn't care that
much.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
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
