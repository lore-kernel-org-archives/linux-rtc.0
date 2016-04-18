Return-Path: <rtc-linux+bncBDS7HNEFSALRBAWC2W4AKGQE44JO72Q@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id d92si25924wma.2.2016.04.18.15.34.41
        for <rtc-linux@googlegroups.com>;
        Mon, 18 Apr 2016 15:34:41 -0700 (PDT)
Date: Tue, 19 Apr 2016 00:34:31 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Joshua Kinard <kumba@gentoo.org>,
	Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: ds1685: actually spin forever in
 poweroff path, part 2
Message-ID: <20160418223431.GC25196@piout.net>
References: <97e46f7b50b413d01be4189159c0611515ef7502.1460729962.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <97e46f7b50b413d01be4189159c0611515ef7502.1460729962.git.jpoimboe@redhat.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 15/04/2016 at 09:21:10 -0500, Josh Poimboeuf wrote :
> objtool reports the following warning:
> 
>   drivers/rtc/rtc-ds1685.o: warning: objtool: ds1685_rtc_poweroff() falls through to next function ds1685_rtc_work_queue()
> 
> Similar to commit 361c6ed6b153 ("rtc: ds1685: actually spin forever in
> poweroff error path"), there's another unreachable() annotation which is
> actually reachable, which we missed the first time.
> 
> Actually spin forever to be consistent with the comment and to make the
> unreachable() annotation guaranteed to be unreachable.
> 
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

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
