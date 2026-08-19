Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F212A394797;
	Wed, 19 Aug 2026 22:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787177385; cv=none; b=X5mkhDjQh4nrzFZVD3Z29SCyAComWh6tDzG92NqGH0O448tKASRSclQqMMs7Z+Goxgd9OXuZ8Xiio90qOiL/05sGucHMhxwpJqHiW1T3H/DyiLV0rp3oiZvQlshHUTlFeG20PA3ywF3f/dFQ2nOHJ/hlEv5kFV65Qtf6GDnhx6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787177385; c=relaxed/simple;
	bh=T8faaoha9+YKrJJVJAyzbhdV/0Blb3ZRcUEfuSKsy/E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BAZzRM7CA7OoUqWHo9v1lVAVhTFDWVdkRYOBqUKCvTYomIeaKbkVsSSzb0tgh6hsik4ZwvRAtKVZm/l5ElGdfcmLZ0O95cUy5yPK4ZG2cTtm03bxzQBXHxCEvCUICZqfeHI6a/G5AlI1oWCBXKGTE62fOVYgBiD7CWn83/SvB1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJmJqLXH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJmJqLXH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D84E1F000E9;
	Wed, 19 Aug 2026 22:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787177383;
	bh=T8faaoha9+YKrJJVJAyzbhdV/0Blb3ZRcUEfuSKsy/E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HJmJqLXHUJePhigWO4Q3QtwpQAnsrXfPqmskFH0hTafA8lZbpX/Hwo4v8Q53z7Ev+
	 XDdHMw1ANJeplFJdSjoyN2pqTnK7bETEzOFya/36pMeOjfU6ZBDEVPwkheu0crY8uN
	 KM729BPNIOX1XUA39XBHhHUdaGzqgfFflRBEQ9re1lRftb8vxhZ2oxOapSHoZiAhae
	 2fAy7+4NAOF52+mkJNJ658b2vmiOjolS5HVxsX4FRgWccz384k36svFXlvO9P99ScZ
	 /c4+DNFxZjap8VHSbSmgzVrqVmiLYE4pev06ty3iQKtt/uHn79JlRDJQ5X+nWCPz1f
	 l5mu3uuiwa1jA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/6] rtc: s35390a: Add missing newline to dev_err
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org
In-Reply-To: <20260820-rtc_s35390a_int1-v5-2-5eb4ef85c6a9@posteo.de>
References: <20260820-rtc_s35390a_int1-v5-0-5eb4ef85c6a9@posteo.de>
 <20260820-rtc_s35390a_int1-v5-2-5eb4ef85c6a9@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 22:09:42 +0000
Message-Id: <20260819220943.3D84E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Fixes: 3bd32722c827d ("rtc: s35390a: improve irq handling")
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820-rtc_s35390=
a_int1-v5-0-5eb4ef85c6a9@posteo.de?part=3D2

