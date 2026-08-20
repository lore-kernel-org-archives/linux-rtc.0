Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7C63F23CF;
	Thu, 20 Aug 2026 09:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787218542; cv=none; b=MicTucvONlNkNSQglA2AlOD5/YGAe0x5IJnu770gIFdzix9D7MjMnVRdwBerY7/JVXcqgTqodKe3i8i0vPooAFAweCXHfI95W4zxgIY2dcCxX7CAZrCsI2h8bYo3dqTLR4YgDggWauTYeEybzoUZkJbkzBABc/bu+YAbjV3utGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787218542; c=relaxed/simple;
	bh=Y4BNjRuor6kx5l4Sx4Jrt2hY7LX5k6pMlRVDdxnsOKc=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=bpQ53rChufHKZiFG3b7NayJ2iLyyXoQo/jygtBUk6ach45kSy8RUuSl5zzT7hEwfYn4UoS/8VyQ/xX87wwBT6ewNciiuJtdgCN8e+Kq9pk4gvZivPd64myYI1jVHebYphCPyQtfndgpw4BMlSlCfPih6escPb4DjFxAGvbKq92E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=v3T4z/qr; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="v3T4z/qr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1787218517; x=1787823317; i=markus.elfring@web.de;
	bh=Y4BNjRuor6kx5l4Sx4Jrt2hY7LX5k6pMlRVDdxnsOKc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=v3T4z/qrY4BeCT6LNP4EAe9KdlhIQ8KA1PWD9BALK2a2TLlttK2rydtgp/29bQc4
	 06jlBQ3Zh5VbUScQKnzyI/nlbMuEZETWuDuf59FDF8rWk0WFlxMwUulrL/uHlBVlP
	 KY8OLlQMSIIYh4k/X1r9DCW7uETVESiwsC47MbVDfTH2QfoL3skG2jlRF+j7JzL/K
	 9YjjRzWEmtvxLjahT1a9hu6Xd2R0og+RQajx2Vb99ijQXasDHWcq2NJiaPA9pRgCK
	 BqJw8ou5pITlJq+y/KdY3Q1v+j6iln4FqvUH6358YpgWNybuG2v99yzFOW80iD07i
	 ctfP3d+9TVizOHZBeg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mty5w-1wgHCz2WI0-016Zxe; Thu, 20
 Aug 2026 11:35:17 +0200
Message-ID: <1f67f9ed-3e84-426e-a671-4baa3c0d6173@web.de>
Date: Thu, 20 Aug 2026 11:35:16 +0200
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: 1298662399@qq.com, linux-rtc@vger.kernel.org,
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <tencent_7FCEEF77654C7D6B110DE49D2E98531A2006@qq.com>
Subject: Re: [PATCH] rtc: rtc-pic32: handle clock enable failure
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <tencent_7FCEEF77654C7D6B110DE49D2E98531A2006@qq.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rNvKGP1FRxIo9itdLzS0LHnDUWwcmsQkNFEzONARChaUQDWNGXU
 n27CDcJd8ZgBFqvGHgS+UnL5Nh0icWDZ5VMtxRmsviX0p6NKZ2KvxCkJCfC+NR4S4fDU11s
 6K2JFPUx3NI/u6ZE11hCbFVVmQ5hr0BuYmC6nFQTPJXr6lnk9/mbowQQ12beP0FzikD43Vv
 gNAc3DAqBsHrk6vibcyYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vevSJ9j/KK0=;uXRTGpPzb02yA0tLefjt8KGfYha
 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

=E2=80=A6
> Check early clk_prepare_enable(pdata->clk) return in pic32_rtc_probe.

I find such a wording approach improvable.
How do you think about to add any tags (like =E2=80=9CFixes=E2=80=9D and =
=E2=80=9CCc=E2=80=9D) accordingly?

See also once more:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/stable-kernel-rules.rst?h=3Dv7.2#n34
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.2#n145
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv7.2#n792


The message recipient specifications should be extended.

Regards,
Markus
