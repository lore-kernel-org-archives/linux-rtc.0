Return-Path: <rtc-linux+bncBDS7HNEFSALRBQV62W4AKGQEBUDUK7I@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id u137si18685wmd.1.2016.04.18.15.27.13
        for <rtc-linux@googlegroups.com>;
        Mon, 18 Apr 2016 15:27:13 -0700 (PDT)
Date: Tue, 19 Apr 2016 00:27:03 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Nicolas Boullis <nboullis@debian.org>
Cc: Alessandro Zummo <a.zummo@towertech.it>, rtc-linux@googlegroups.com
Subject: [rtc-linux] Re: [PATCH 1/2] rtc: ds1307: fix ds1307_native_smbus_read_block_data
 function
Message-ID: <20160418222703.GZ25196@piout.net>
References: <20160402221037.GA3600@haddock.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <20160402221037.GA3600@haddock.home>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 03/04/2016 at 00:10:37 +0200, Nicolas Boullis wrote :
> The i2c_smbus_read_i2c_block_data function returns 0 on success, not the 
> number of bytes written.
> 
> Hence, when there are 32 bytes or less to send, the 
> ds1307_native_smbus_write_block_data function returns 0 on success, 
> while it returns the number of bytes when there are more than 32.
> 
> The ds1307_write_block_data always returns the number of bytes on 
> success.
> 
> Signed-off-by: Nicolas Boullis <nboullis@debian.org>
> 
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
