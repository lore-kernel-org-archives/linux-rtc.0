Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795676483;
	b=sr59ppUec0eXCYkAuCd5J4TTWJX2UbZbz114NsuizEfzxTG/PZlrVF8ipta/u5J+nWKZ
	 ZJ31LUat3gDBFmjFTwlkUHzxvz46G8mhtpfC4blgVI07Fbe3aJqoIgQfyvj/8v1CB3P1d
	 2q69fLa+mt9mytYEf1yrL7xqn5fxUqJdw3+LeV6vvU4xlK4xDbfZu4DeT+t61zyh3Q2jv
	 mPei1UcEAnC1mNuluN+/Wb6ZskZfSQRIG5LvGVvBxdLSTjsvnBcm5G5gu895r4gVAVgrC
	 2bZAw1IFSZVlP6KRhxHFYjpGG3FHjBYt6VbECtzfBknvnQV8ct3jqWWOBXUZ9nmjnFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795676483;
	h=Received:DKIM-Signature:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=b/rML115dKLyfpXZUpn0F/pM5VpWWk5aIA7OTC4Pxwg=;
	b=32yLGyiC+OLr3yUFtfojFvnPEF6lYdau9na7lay56DHp0qCQzozWJyF9pT1mQfsU6k89
	 zGMc4vcnyv2Q91zFZrF1EbnCADUsFT9Rl1YS8VL4TcKs35YQWL9hJE0ehECv3d7sOiE3J
	 UUC8IXdm1lkO5WBTAKrTpCPj/4u4Ld3YqQtr5dj2XTpPvi2wamq4Rnao40K/ce6qBNptX
	 Em2X1NYXvzg4qGzc6TqHmAf9C4JZ3orrUCokK15HBP6/C/NggRr5UB8FEc1JqRFDFENMO
	 Oo3nRp8N6PeJZHdlp1WWp8lPysRu7cO/r1S4uGMMs12cwIma3CKDDeLlUpEqPAh/2ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWjELeBc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE816606A31C;
	Thu, 26 Nov 2026 07:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UWjELeBc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476921F000C0;
	Thu, 26 Nov 2026 07:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795676483;
	bh=b/rML115dKLyfpXZUpn0F/pM5VpWWk5aIA7OTC4Pxwg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UWjELeBcYpy/nEqiKpDPY/sAHJSiZxz7ROOHeugiYJ7FAdyteRBC6U8dVBDC2BD0u
	 OEZh5U1Orw5khC4cWQUoKEH74B+scM8afQXLzSW6mEqRpJfBBX29c4LHdauopXN1RE
	 zpYo5xXS/KOG0KwqOZ5BMaSmGpg0y8ilbC0PRQJKsPEJ29Sn+v6pbQe6nDdAua5l95
	 NuONpOgK5zGVO/u6ZCKaK60UwQC7TZpeOm1U7Vz6+YKA8I+C/1iTmf+eYTYAmG6dIT
	 HMUFP53LkCNSjA6plqz2YIp4xPqPSSGeR97lESsqYmDSsHGS+BXDLQe+fRSnai+H3s
	 wB5cLpO6zw/Ew==
Received: from johan by xi.lan with local (Exim 4.100.1)
	(envelope-from <johan@kernel.org>)
	id 1xWTTs-00000000y9w-1yEr;
	Thu, 26 Nov 2026 08:01:20 +0100
Date: Thu, 26 Nov 2026 08:01:20 +0100
From: Johan Hovold <johan@kernel.org>
To: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>,
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-rtc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] rtc: pm8xxx: Don't fail probe if the UEFI offset
 variable is missing
Message-ID: <awfZQEs2PmbPtcHM@hovoldconsulting.com>
References: <20261126055009.758156-1-gopikrishna.garmidi@oss.qualcomm.com>
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Post: <mailto:linux-rtc@vger.kernel.org>
List-Help: <mailto:linux-rtc+help@vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-rtc+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126055009.758156-1-gopikrishna.garmidi@oss.qualcomm.com>

On Wed, Nov 25, 2026 at 09:50:09PM -0800, Gopikrishna Garmidi wrote:
> On boards that set qcom,uefi-rtc-info, the RTC offset is read from the
> RTCInfo UEFI variable at probe time. Not every firmware creates this
> variable. On the Microsoft Surface Laptop 8th Edition the variable store
> is accessible but RTCInfo does not exist, so the read returns
> EFI_NOT_FOUND and the probe fails:
> 
>   rtc-pm8xxx c426000.spmi:pmic@0:rtc@6100: probe with driver
>   rtc-pm8xxx failed with error -2
> 
> As no RTC device is registered, the time can never be set and the
> variable is never created.

No, this is working as intended and the driver should not create this
variable.

If the firmware doesn't set this variable then this platform uses some
other means to store the RTC time. Please add support for that so that
the time is synchronised with UEFI setup (and any other OS).

The devicetree property in question describes how the platform works,
it's not a configuration flag.

Also see:

	https://lore.kernel.org/all/aoxrOaY7RIFEqVr2@hovoldconsulting.com/

> Treat a missing variable as a zero offset. It gets written the first
> time the time is set, as for any other offset update.
> 
> Fixes: bba38b874886 ("rtc: pm8xxx: add support for uefi offset")

This is clearly not a fix in any case.

> Signed-off-by: Gopikrishna Garmidi <gopikrishna.garmidi@oss.qualcomm.com>

Johan
