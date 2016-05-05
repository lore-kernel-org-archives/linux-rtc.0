Return-Path: <rtc-linux+bncBDS7HNEFSALRBQGMVS4QKGQELFQILRA@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail.free-electrons.com (down.free-electrons.com. [37.187.137.238])
        by gmr-mx.google.com with ESMTP id k143si116380wmg.1.2016.05.05.03.53.51
        for <rtc-linux@googlegroups.com>;
        Thu, 05 May 2016 03:53:51 -0700 (PDT)
Date: Thu, 5 May 2016 12:53:51 +0200
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: venkat.prashanth2498@gmail.com
Cc: a.zummo@towertech.it, marcus.folkesson@gmail.com,
	rtc-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH] rtc: add support for maxim rtc max6916
Message-ID: <20160505105351.GA2890@piout.net>
References: <1462442989-3894-1-git-send-email-venkat.prashanth2498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1462442989-3894-1-git-send-email-venkat.prashanth2498@gmail.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

Hi,

On 05/05/2016 at 03:09:49 -0700, venkat.prashanth2498@gmail.com wrote :
> From: venkat-prashanth <venkat.prashanth2498@gmail.com>
> 
> This a patch to add support for
> maxim rtc max6916
> 
> Signed-off-by: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
> ---
> ---
>  drivers/rtc/rtc-max6916.c | 165 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 165 insertions(+)
> 

This is the second version you send since my comments. Please include
the patch version in the subject line.
Also, you need to include a changelog.
Finally, you didn't address many of my comments please do so before
submitting again.


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
