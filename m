Return-Path: <rtc-linux+bncBAABBPHKQOZQKGQEEXX7SNQ@googlegroups.com>
Received: from userp1040.oracle.com (userp1040.oracle.com. [156.151.31.81])
        by gmr-mx.google.com with ESMTPS id pe1si1364451pac.2.2015.12.03.18.06.51
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Dec 2015 18:06:52 -0800 (PST)
Subject: [rtc-linux] Re: [PATCH] rtc: fix overflow and incorrect calculation
 in rtc_time64_to_tm
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
References: <1449187944-11730-1-git-send-email-sasha.levin@oracle.com>
 <20151204015554.GB3515@piout.net>
Cc: a.zummo@towertech.it, rtc-linux@googlegroups.com,
        linux-kernel@vger.kernel.org
From: Sasha Levin <sasha.levin@oracle.com>
Message-ID: <5660F533.1070705@oracle.com>
Date: Thu, 3 Dec 2015 21:06:43 -0500
MIME-Version: 1.0
In-Reply-To: <20151204015554.GB3515@piout.net>
Content-Type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 12/03/2015 08:55 PM, Alexandre Belloni wrote:
> On 03/12/2015 at 19:12:24 -0500, Sasha Levin wrote :
>> > At some point after humans go extinct and robots cotrol the world, dividing
>> > he time64_t by 86400 to extract the days will overflow a 32bit integer,
>> > leading to incorrect conversion into rtc_time in rtc_time64_to_tm().
>> > 
> And at that time, the robots won't care about 32bit platforms :)

One can only hope... :)

I'll resend.


Thanks,
Sasha

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
