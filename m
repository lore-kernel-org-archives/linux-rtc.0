Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CC739CCFE
	for <linux-rtc@vger.kernel.org>; Tue, 29 Sep 2026 21:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790718701; cv=none; b=YEsRkD5gDOGfiWreCrB+pnAEvgdkg91VLCPxna7igSP+Uuh6yIp7FfKl2QBo8YyMhcm2/4DVeriBQg6r5eRkIzIc1EZXPOjDIf4FLl3rQ8Qgw98RdV9bblcJNGcNOwlFf1taHlkeoNdaw2uz++Tj+T0e+zVnAZsFHWP2q6QITh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790718701; c=relaxed/simple;
	bh=eK2PtC92sJFT88bmeOIAqumkvWEPGHE7U5feJBsglvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QgBHGVsZaseWel3PtXHuYVVcPBSsVyEM0Y8VtZQWNkHIs7RU3ElDS162wqutS1hD5Xc2wzVpk1jhwtFAZc0o1Vz64qk+NSj1ThSUfubB9Vq+ERCZSL6QYXaCtaHaBMHqEwTBckeYvjC2CzuW1jpk1BK+a5UnbjttC7MGXlDJyUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ev0orxJp; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ev0orxJp"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 9725F1A1062;
	Tue, 29 Sep 2026 21:51:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 53A4E601BD;
	Tue, 29 Sep 2026 21:51:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E8BB1103294BA;
	Tue, 29 Sep 2026 23:51:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790718688; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 in-reply-to:references; bh=tQCEIW6sZfDTGWEqD2K++zvCQ0QP/SxrExfnSipGS3s=;
	b=Ev0orxJpsQrnvT6TlcsBYv9oV1uuAv/wKlMRV9dOcKf+aB6gZg/IcgxHmRCwWcIRz1oxkf
	ZsoRXZxnzJXdXXIDDksuGP1N709N3DApfEYx8C31I1R6fssa7YaS4HsijHiyf53KGZf2aw
	k9slnOhC1hFP438KHgh8oPwLK8jmXdCRvRAEPukc3/liW1mEwWdm+9e770VqVKxXueVv01
	2dzSmDmdeOAiMQsIOmizAA9cJTrs2VH16RqXqT0lAU81PUUZ17qbOP24181nqEouyJI/Fy
	y8pvoOPEbyJqCN1y/VaXS4P4UVYV+HmUJ2GrzrB7pjJhzighDdKn4VSLteTPnw==
Date: Tue, 29 Sep 2026 23:51:26 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Satya Priya <quic_c_skakit@quicinc.com>,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Dhruvin Rajpura <dhruvin.rajpura@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: rtc: qcom-pm8xxx: Document PMM8654AU RTC
Message-ID: <20260929215126558a0a33@mail.local>
References: <20260904074541.590485-1-shengchao.guo@oss.qualcomm.com>
 <arpTJAyDAAuAzPrv@QCOM-aGQu4IUr3Y>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arpTJAyDAAuAzPrv@QCOM-aGQu4IUr3Y>
X-Last-TLS-Session-Version: TLSv1.3

On 28/09/2026 19:44:36+0800, Shawn Guo wrote:
> On Fri, Sep 04, 2026 at 03:45:41PM +0800, Shawn Guo wrote:
> > Document Qualcomm PMM8654AU PMIC RTC which is compatible with PMK8350
> > RTC.
> > 
> > Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> 
> Hi Alexandre,
> 
> I have a DTS series depending on this change and so that being blocked
> for weeks. I will include it into the DTS series to unblock the
> progress (routing it through arm-soc tree).
> 

Sorry, I didn't realize this was blocking you and was going to apply
this with super low priority, this can go through soc.

Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
