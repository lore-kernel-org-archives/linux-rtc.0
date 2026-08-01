Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678E330C359;
	Sat,  1 Aug 2026 18:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785610013; cv=none; b=j4YLTm24EbuIj5FT8JtzeUz5mxFs/YrdWxAguD8l2PZg4LfjHymlmzF8NjYwhmHMqXtQzEyLTuMkdX8g+OuOEJSA9ODVTkoeqhGSjwWKkzS/pJYXvbwHP27QEop8KG5hkQkoUyYdeXF+baFHPdYQGCHDdPd26mcPP+7Xaq9LrYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785610013; c=relaxed/simple;
	bh=OPYKqBCzNpff9A2ybyr4+9YnJBVp0gqdgQ+pV2dlsEk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NDPyogN02Dfl/4y38NduWz+QIvevi9wyxhWJSj3sl/ShSRWf5f4NWyLtN/N6iVSJ/W1SOjToxTYlD9WH59TRHtPa6TbsiwoXmpjmtKmWlpVVP51gUeNTcrKpawmp1c47DXD0mPW9UMgf+B7ZqnFISnG0dpiW0O2Au+0cP1C0kJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tu5qHkFM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tu5qHkFM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33251F00ACA;
	Sat,  1 Aug 2026 18:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785610012;
	bh=OPYKqBCzNpff9A2ybyr4+9YnJBVp0gqdgQ+pV2dlsEk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Tu5qHkFMzA6GU1kxCc3gQ7VLribMefbjstuYiSmpAaWH/lJpDcIWRgFotBChnrRrY
	 qOWZZp8bOxgwzZH2tQcEuiLv76H/5UHBEPnxhfTTKs23A7u5t2z5gFRGLRotthjzmI
	 owSDqUwJiu1p84hIZcCBZAOCystCPDZwZ5Bdw2+quuVsegiO5HzRnqOZdO+e7BTdML
	 SkKIZEcaCZ9ekP7+h5fLqekuhZGXV6RmUfOrN4s2crtmZNOJeOJtp+xeCCBJDlNAXM
	 77mcy7qiKlc/ISMFCRl3oD1a+XpdEiZ64h14rF7Rx5r0oJm7v0Ha5qrWxUw2hlUUPp
	 mbolZ+6GLZWvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/5] rtc: s35390a: Add missing newline to dev_err
Reply-To: sashiko-reviews@lists.linux.dev
To: "Markus Probst" <markus.probst@posteo.de>
Cc: robh@kernel.org, devicetree@vger.kernel.org, linux-rtc@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, conor+dt@kernel.org
In-Reply-To: <20260801-rtc_s35390a_int1-v2-2-f10c99ad1d6c@posteo.de>
References: <20260801-rtc_s35390a_int1-v2-0-f10c99ad1d6c@posteo.de>
 <20260801-rtc_s35390a_int1-v2-2-f10c99ad1d6c@posteo.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 18:46:51 +0000
Message-Id: <20260801184651.C33251F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rtc@vger.kernel.org
List-Id: <linux-rtc.vger.kernel.org>
List-Subscribe: <mailto:linux-rtc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rtc+unsubscribe@vger.kernel.org>

> Fixes: 3bd32722c827d ("rtc: s35390a: improve irq handling")
> Signed-off-by: Markus Probst <markus.probst@posteo.de>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801-rtc_s35390=
a_int1-v2-0-f10c99ad1d6c@posteo.de?part=3D2

