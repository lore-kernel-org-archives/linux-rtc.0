Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4EF12E7657;
	Thu, 20 Aug 2026 10:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787220341; cv=none; b=BuQ6qu+fw0pw/wrh9qO9TJo7us52HMOje4/eApjdSOJ2FdK+ovW3OssJ5982Tv05YnUitfVfSjADuNxCIcN+a2O5XXjn1XFbkKdaNogz77emr/X8f0WzZHVFTBUK/40TxAIFbXspaOwq5ZLi2J1gWwTKWdaipUDB5UaRvG+78r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787220341; c=relaxed/simple;
	bh=WajWXnw0CgUUVqpIKpN2+Iyn7+17Fofdf3zq/+JwmCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VIfE075WLNOjnR00I/8UuuzQVGOt3U/r/o1ctPMleFgES+b8O/8RO8vlwP9BL0GHAFCCXxd19YSjTX+fggfGi1w24Vi6g3fFhxLbXMpUnv4rNhSJxXBllgjkm1VTkNV0efor49+y/ZV4HR1Yd1FQ2d9aCt9NAcm+TzhBxxd8fto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=mXGfFQTq; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="mXGfFQTq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787220266; x=1787825066; i=markus.elfring@web.de;
	bh=mJtJBu3gPgG3DQuPv5ziwtmRQrNuKny2rDtF2eoVbJA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=mXGfFQTqHvkzkTkpWTBuCrmL3T3rFXKP2X2bX9+1wL8GbnSQp9JkSWEzHbOVBbI7
	 9wOwHzyHJQlAIbMBWIn8u8FnSVrS9Yi+bz6mUQQqoAz9J+7keiEzg29lfvNY4991F
	 rLyTNyhJulWQx8IuwYXP0X2s6o9fFuyhevuxVJVJftlkygU9GSx4IBEMZFPAjkZ3x
	 xUEEMGW/VmgsdNPS2m3xU5iXc62VNJCJe2IuhkNvV27XphRIS0eoyDBy0wfEElD2Z
	 vUG5uNCtiOldaq+zaUH5Qdin5r1jTaEr+1Hr13tZGja9jYcyyd0OnLowC7jNlhfFH
	 yIJHD08SRijFIbiC9Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1My6lX-1wkPV02c5X-015pLW; Thu, 20
 Aug 2026 12:04:25 +0200
Message-ID: <120cb9fe-4429-4fd0-9940-55a2783ed2ea@web.de>
Date: Thu, 20 Aug 2026 12:04:23 +0200
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rtc: rtc-pic32: handle clock enable failure
To: "Robert P. J. Day" <rpjday@crashcourse.ca>, linux-rtc@vger.kernel.org
Cc: 1298662399@qq.com, Alexandre Belloni <alexandre.belloni@bootlin.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <tencent_7FCEEF77654C7D6B110DE49D2E98531A2006@qq.com>
 <1f67f9ed-3e84-426e-a671-4baa3c0d6173@web.de>
 <66852c50-85fc-f5ff-46a4-5bd65e087c9d@crashcourse.ca>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <66852c50-85fc-f5ff-46a4-5bd65e087c9d@crashcourse.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2b/VEsZi+exOCvQ8hp7xhgveoxna2R5PPOYRi+T6IUNLhnlSjmN
 4E6dKgeAh8XN2LyS+lbxiZY2NYeeOI7yTsrmb7skcEOkqcu1S9emW5uNMaHa9PoF+Au1WGj
 237cAkHzFFl/jym96sQbdLBmC2wjay6z/NsW4/qlFfgHH+o5e1H8vrwraKh+hO6f+MsiqL+
 wZQfWG7F91iFH9hPTA39w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EoqY2hPk0HQ=;1DNmRw37TpUMoMO9VvVJcfI58QC
 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

>> =E2=80=A6
>>> Check early clk_prepare_enable(pdata->clk) return in pic32_rtc_probe.
>>
>> I find such a wording approach improvable.
>> How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D an=
d =E2=80=9CCc=E2=80=9D) accordingly?
>=20
>   How many times are you going to ask this same question?
I got the impression that another reminder would be needed also for the pr=
esented patch.

Regards,
Markus
