Return-Path: <rtc-linux+bncBCUJ7YGL3QFBBHP5VXDAKGQE7NXTRGA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org. [140.211.169.12])
        by gmr-mx.google.com with ESMTPS id y90si1276444pfa.6.2017.03.16.23.13.49
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Mar 2017 23:13:49 -0700 (PDT)
Date: Fri, 17 Mar 2017 15:13:34 +0900
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: kernel test robot <fengguang.wu@intel.com>, LKP <lkp@01.org>,
	linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com,
	wfg@linux.intel.com
Subject: [rtc-linux] Re: [rtc] 4cd8adb100: WARNING: CPU: 0 PID: 1 at
 lib/kobject.c:690 kobject_put
Message-ID: <20170317061334.GA2847@kroah.com>
References: <58cb6cce.GwD02K343UlZPrBA%fengguang.wu@intel.com>
 <72ddb00d-3eda-1a16-9c3b-10055dd4e730@deltatee.com>
 <20170317061137.GA21612@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20170317061137.GA21612@kroah.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Fri, Mar 17, 2017 at 03:11:37PM +0900, Greg Kroah-Hartman wrote:
> On Thu, Mar 16, 2017 at 11:23:26PM -0600, Logan Gunthorpe wrote:
> > Hey,
> > 
> > I think I see the issue here: in a couple of error conditions, the RTC
> > code will not initialize and ask for the cdev. However, my change will
> > always call cdev_add and cdev_del even though the rtc code did not call
> > cdev_init. I'll have to add a guard around dev->devt in the new
> > cdev_device functions. I'll prepare another patch tomorrow.
> > 
> > I also noticed that I neglected to remove the prototypes for the two RTC
> > function I removed. I'll fix that too.
> 
> Ok, I'm just going to drop this series from my tree so that other
> patches in it can get pushed out to linux-next.  Please resend the full
> series after you have fixed it up, and I'll be glad to queue it up
> again.

Also, when you resend, if you can collect the acks from the subsystem
maintainers, and add them to the patches, that would be very good.

thanks,

greg k-h

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
