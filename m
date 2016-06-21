Return-Path: <rtc-linux+bncBDJIP47K7MERBBHLU25QKGQEGH67EYQ@googlegroups.com>
Sender: rtc-linux@googlegroups.com
Received: from mail-oi0-f68.google.com (mail-oi0-f68.google.com. [209.85.218.68])
        by gmr-mx.google.com with ESMTPS id o1si306192ith.1.2016.06.21.14.45.40
        for <rtc-linux@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2016 14:45:40 -0700 (PDT)
Received: by mail-oi0-f68.google.com with SMTP id x6so870256oif.3
        for <rtc-linux@googlegroups.com>; Tue, 21 Jun 2016 14:45:40 -0700 (PDT)
Date: Tue, 21 Jun 2016 16:45:39 -0500
From: Rob Herring <robh@kernel.org>
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: rtc-linux@googlegroups.com,
	Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>,
	devicetree@vger.kernel.org
Subject: [rtc-linux] Re: [PATCH 1/4] devicetree: Add Micro Crystal AG vendor id
Message-ID: <20160621214539.GA9080@rob-hp-laptop>
References: <1466492240-5528-1-git-send-email-dirk.behme@de.bosch.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
In-Reply-To: <1466492240-5528-1-git-send-email-dirk.behme@de.bosch.com>
Reply-To: rtc-linux@googlegroups.com
List-ID: <rtc-linux.googlegroups.com>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux@googlegroups.com>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help@googlegroups.com>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe@googlegroups.com>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe@googlegroups.com>,
 <https://groups.google.com/group/rtc-linux/subscribe>

On Tue, Jun 21, 2016 at 08:57:17AM +0200, Dirk Behme wrote:
> From: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
> 
> Signed-off-by: Oleksij Rempel <fixed-term.Oleksij.Rempel@de.bosch.com>
> Cc: devicetree@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 2c2500d..a6b39f9 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -152,6 +152,7 @@ lsi	LSI Corp. (LSI Logic)
>  lltc	Linear Technology Corporation
>  marvell	Marvell Technology Group Ltd.
>  maxim	Maxim Integrated Products
> +mc	Micro Crystal AG

mc is a bit short. How about microcrystal?

>  meas	Measurement Specialties
>  mediatek	MediaTek Inc.
>  melexis	Melexis N.V.
> -- 
> 2.8.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/d/optout.
