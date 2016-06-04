Return-Path: <rtc-linux+bncBCKYNX7Y3IMBBNOBZO5AKGQEIU6PRQA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id s140si510032wme.1.2016.06.04.07.07.49
        for <rtc-linux@googlegroups.com>;
        Sat, 04 Jun 2016 07:07:49 -0700 (PDT)
Date: Sat, 4 Jun 2016 16:07:48 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: venkat.prashanth2498@gmail.com
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-kernel@vger.kernel.org, k.kozlowski@samsung.com,
	marcus.folkesson@gmail.com
Subject: [rtc-linux] Re: [PATCH v4] rtc:add support for maxim rtc max6916
Message-ID: <20160604140748.GL4594@piout.net>
References: <1464762594-2336-1-git-send-email-venkat.prashanth2498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1464762594-2336-1-git-send-email-venkat.prashanth2498@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On 01/06/2016 at 11:59:54 +0530, venkat.prashanth2498@gmail.com wrote :
> From: VENKAT PRASHANTH B U <venkat.prashanth2498@gmail.com>
> 
> This is a patch to add support for
> maxim rtc max6916
> 
> Signed-off-by: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
> ---
> changelog v4:
> - fixed the line wrapping to around 72 characters
> - Aligned the values with tabs
> - inserted the correct coding style in the conditional statements
> - removed the empty lines towards the end of the code
> - fixed the checkpatch issues
> - code clean up on max6916_read_reg()
> 
> changelog v3:
> - saperated the logical code sections with an empty line
> - used indentations after if statements.
> - fixed the out of tree makefile
> - placed the test condition at the begining of the function
> 
> change log v2:
> - deleted the port i/o's
> - clock burst value is modified from 0x00 to 0x3F
> - The time in linux is in binary format so get_rtc()replaced with bcd2bin()
> - enforced the year range instead of accepting any value
> ---
> ---
>  drivers/rtc/Kconfig		|  12 ++++
>  drivers/rtc/Makefile		|   1 +
>  drivers/rtc/rtc-max6916.c	| 167 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 180 insertions(+)
> 

I've applied it but you probably edited the diff by hand so I had to
edit it a bit more to get it to apply correctly. Also, I fixed the
remaining checkpatch issues.

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
