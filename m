Return-Path: <rtc-linux+bncBDEZ72H55YIBB3V6VSXAKGQEDZJQK5A@googlegroups.com>
Received: from mailout1.samsung.com (mailout1.samsung.com. [203.254.224.24])
        by gmr-mx.google.com with ESMTPS id zg3si546023pbc.1.2015.08.12.03.26.53
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 12 Aug 2015 03:26:54 -0700 (PDT)
Received: from epcpsbgr1.samsung.com
 (u141.gpu120.samsung.co.kr [203.254.230.141])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7.0.5.31.0
 64bit (built May  5 2014))
 with ESMTP id <0NSY02YYLT0R1W50@mailout1.samsung.com> for
 rtc-linux@googlegroups.com; Wed, 12 Aug 2015 19:26:51 +0900 (KST)
Message-id: <55CB1F6C.4080207@samsung.com>
Date: Wed, 12 Aug 2015 19:26:52 +0900
From: Joonyoung Shim <jy0922.shim@samsung.com>
MIME-version: 1.0
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 a.zummo@towertech.it, alexandre.belloni@free-electrons.com,
 cw00.choi@samsung.com
Subject: [rtc-linux] Re: [PATCH 3/4] rtc: s3c: use unified functions for
 enable/disable of clk
References: <1439292502-22912-1-git-send-email-jy0922.shim@samsung.com>
 <1439292502-22912-3-git-send-email-jy0922.shim@samsung.com>
 <55CA8EDE.8000006@samsung.com>
In-reply-to: <55CA8EDE.8000006@samsung.com>
Content-type: text/plain; charset=UTF-8
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <http://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/rtc-linux
Sender: rtc-linux@googlegroups.com
List-Subscribe: <http://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <http://groups.google.com/group/rtc-linux/subscribe>

On 08/12/2015 09:10 AM, Krzysztof Kozlowski wrote:
> On 11.08.2015 20:28, Joonyoung Shim wrote:
>> The driver uses clk_prepare_enable()/clk_disable_unprepare() only in
>> probe only, elsewhere, use the unified functions for enable/disable of
>> clk, e.g. s3c_rtc_enable_clk() / s3c_rtc_disable_clk(), so it's better
>> to use them for consistency of code.
>>
>> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
>> ---
>>  drivers/rtc/rtc-s3c.c | 14 +++++++++-----
>>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> First of all - the code is larger (9 insertions, 5 deletion) so I have
> doubts if this is better.
> 
> Second - this is not equivalent change. The s3c_rtc_enable_clk/disable
> calls grab spin lock which is not necessary in probe.
> 

I made this patch because of patch 4/4, but patch 4/4 should be removed
dependency from previous patches, so i will drop this patch.

Thanks.

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
