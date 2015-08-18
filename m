Return-Path: <rtc-linux+bncBDKZNNNLXAHBBM4MZOXAKGQE7MBDJGA@googlegroups.com>
Received: from mailout4.w1.samsung.com (mailout4.w1.samsung.com. [210.118.77.14])
        by gmr-mx.google.com with ESMTPS id dx8si1117463pab.1.2015.08.17.22.44.19
        for <rtc-linux@googlegroups.com>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 17 Aug 2015 22:44:19 -0700 (PDT)
Received: from eucpsbgm1.samsung.com (unknown [203.254.199.244])
 by mailout4.w1.samsung.com
 (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014))
 with ESMTP id <0NT900CXRJXR2P00@mailout4.w1.samsung.com> for
 rtc-linux@googlegroups.com; Tue, 18 Aug 2015 06:44:15 +0100 (BST)
Message-id: <55D2C62B.1010209@samsung.com>
Date: Tue, 18 Aug 2015 14:44:11 +0900
From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
MIME-version: 1.0
To: Joonyoung Shim <jy0922.shim@samsung.com>, rtc-linux@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 stable@vger.kernel.org, a.zummo@towertech.it,
 alexandre.belloni@free-electrons.com, cw00.choi@samsung.com
Subject: [rtc-linux] Re: [PATCH v2] rtc: s3c: fix disabled clocks for alarm
References: <1439374906-27841-1-git-send-email-jy0922.shim@samsung.com>
In-reply-to: <1439374906-27841-1-git-send-email-jy0922.shim@samsung.com>
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

On 12.08.2015 19:21, Joonyoung Shim wrote:
> The clock enable/disable codes for alarm have been removed from
> commit 24e1455493da ("drivers/rtc/rtc-s3c.c: delete duplicate clock
> control") and the clocks are disabled even if alarm is set, so alarm
> interrupt can't happen.
> 
> The s3c_rtc_setaie function can be called several times with 'enabled'
> argument having same value, so it needs to check whether clocks are
> enabled or not.
> 
> Signed-off-by: Joonyoung Shim <jy0922.shim@samsung.com>
> Cc: <stable@vger.kernel.org> # v4.1
> ---
> This is v2 of prior patch "[PATCH 4/4] rtc: s3c: enable/disable clocks
> for alarm".
> 
> Changelog for v2:
> - commit messages is modified by Krzysztof suggestion
> - make to backportable patch
> - add Cc-stable
> 
>  drivers/rtc/rtc-s3c.c | 24 ++++++++++++++++++------
>  1 file changed, 18 insertions(+), 6 deletions(-)
> 

Looks good now:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Best regards,
Krzysztof

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
