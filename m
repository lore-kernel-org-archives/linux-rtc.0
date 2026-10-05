Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 048E7390618;
	Mon,  5 Oct 2026 20:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791232302; cv=none; b=q2YO+ARXBDZO3bd0ioisR40q+Do3RlmyQWEn4ccO7dj05OMQsnNGTk2hP7M9t3QzCjU1y8j+WGjF2dIEraR7XsGbGuhvGMh1f2DdXjbft/9hQXR0ui1PKZ+j9m6eio8aeO1A4zSmvnWapHV1OHFDGO/fZi+sN8gwzjX17nrm9Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791232302; c=relaxed/simple;
	bh=bqEiaEaQAC9tNxFjPhTe3Rxp4cICMoxfnFRUCknNGTY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T3/h1sJLKIwQCbpFWAt50Npobggu2981CWVQ7DQeg/RabEuL/Cq04VxP60MAuftQrh0fSAvjUM8r0kpExzaCMmCSP0Ps3iLZXUi2oz7NF89Z3H17g89tqtNDgBWRVT920yq/D8TM8Jjjz0RfpPxfQKLyYr1zFQ1JxSQe+kvMjdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EuOrDuDc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EuOrDuDc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABC421F000FF;
	Mon,  5 Oct 2026 20:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791232295;
	bh=bqEiaEaQAC9tNxFjPhTe3Rxp4cICMoxfnFRUCknNGTY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EuOrDuDcxM/zvm71BydMKxTqm7YcRLdxZBZl5Q2Cme67VhZa/AfdyDAtb6vjVMdZQ
	 7ZBJhehnMxWVuIAicyMlO7PGh//fK1xZCG8/AdM01DSigAv06D9xDM90UG2OWfeD87
	 KKAOdYoU0GjmWwKSlRvAY0A+7H6Qvw6L4Zy5d8fG8xPHPbDCI9ZnMeHPsGdpHA0roT
	 AlgW58GsUDflENFDQeFixtYwPhVixiD8dH4peQwkGrDaO+jLGLfy9YatqEKVYY7dZd
	 Jy/k3wXycOzP7rxPc37KkdvxDjYkAgYOz6mRFBlus9aiSfPgBswUhrHY6m1NtJGGds
	 xyt02xqrRdZ3A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/11] dt-bindings: rtc: sun6i-a31: add Allwinner
 B288
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pablo Mazzini" <pmazzini@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>
In-Reply-To: <20261005202731.153971-6-pmazzini@gmail.com>
References: <20261005202731.153971-1-pmazzini@gmail.com>
 <20261005202731.153971-6-pmazzini@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 05 Oct 2026 20:31:34 +0000
Message-Id: <20261005203134.ABC421F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> The B288 RTC wires one alarm interrupt, not two.
>=20
> Signed-off-by: Pablo Mazzini <pmazzini@gmail.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261005202731.1539=
71-1-pmazzini@gmail.com?part=3D5

