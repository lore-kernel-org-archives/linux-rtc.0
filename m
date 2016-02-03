Return-Path: <rtc-linux+bncBDS7HNEFSALRBA57Y62QKGQEFSQAZGI@googlegroups.com>
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id v7si153836wmg.3.2016.02.03.03.07.47
        for <rtc-linux@googlegroups.com>;
        Wed, 03 Feb 2016 03:07:47 -0800 (PST)
Date: Wed, 3 Feb 2016 12:07:05 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: dirk.behme@gmail.com
Cc: rtc-linux <rtc-linux@googlegroups.com>,
	Dirk Behme <dirk.behme@de.bosch.com>,
	Oleksij Rempel <linux@rempel-privat.de>
Subject: [rtc-linux] Re: rtc: RV8803: BUG: scheduling while atomic
Message-ID: <20160203105717.GA20165@piout.net>
References: <460eec38-0a09-4faa-b601-de64803ed5f3@googlegroups.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <460eec38-0a09-4faa-b601-de64803ed5f3@googlegroups.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 03/02/2016 at 01:31:21 -0800, dirk.behme@gmail.com wrote :
> Testing the RV8803 driver [1] we are getting several "BUG: scheduling while 
> atomic" [2].
> 
> Having a quick look this might be from rv8803_set_time() holding a spinlock 
> during the call to i2c_smbus_read_byte_data()?
> 
> Any ideas?
> 

Yes, that is probably the case. As this is already a threaded irq, it
can probably be changed into a mutex this would solve the issue. Can you
try that? I don't have much time to do it myself right now.


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
